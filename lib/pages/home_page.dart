import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clinkk_assignment_to_do_app/pages/posts_page.dart';
import 'package:clinkk_assignment_to_do_app/pages/to_do_pages.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const HomePage({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getStringList('tasks') ?? [];
    setState(() {
      _tasks = savedTasks
          .map((task) {
            final parts = task.split('|');
            if (parts.length == 4) {
              return {
                'title': parts[0],
                'subject': parts[1],
                'dateTime': DateTime.tryParse(parts[2]),
                'isCompleted': parts[3] == 'true',
              };
            }
            return null;
          })
          .where((task) => task != null) // Remove null entries
          .cast<Map<String, dynamic>>()
          .toList();
    });
  }

  void _deleteTask(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks.removeAt(index);
    });
    final updatedTasks = _tasks
        .map((task) =>
            '${task['title']}|${task['subject']}|${task['dateTime'].toIso8601String()}|${task['isCompleted']}')
        .toList();
    prefs.setStringList('tasks', updatedTasks);
  }

  void _updateTaskStatus(int index, bool isCompleted) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks[index]['isCompleted'] = isCompleted;
    });
    final updatedTasks = _tasks
        .map((task) =>
            '${task['title']}|${task['subject']}|${task['dateTime'].toIso8601String()}|${task['isCompleted']}')
        .toList();
    prefs.setStringList('tasks', updatedTasks);
  }

  Future<void> _navigateToAddTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoPage()),
    );
    if (result != null) {
      _loadTasks(); // Reload tasks when a new task is added
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('To-Do App')),
          backgroundColor: Colors.teal, //teal color
          actions: [
            IconButton(
              icon: Icon(
                widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white,
              ),
              onPressed: widget.toggleTheme,
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.list),
                    SizedBox(width: 8),
                    Text('To-Do List'),
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.article),
                    SizedBox(width: 8),
                    Text('Posts'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Expanded(
                  child: _tasks.isEmpty
                      ? Center(
                          child: Text(
                            'No tasks available!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _tasks.length,
                          itemBuilder: (context, index) {
                            final task = _tasks[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: ListTile(
                                leading: Checkbox(
                                  value: task['isCompleted'],
                                  onChanged: (value) {
                                    _updateTaskStatus(index, value!);
                                  },
                                ),
                                title: Text(
                                  task['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: task['isCompleted']
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Subject: ${task['subject']}'),
                                    Text(
                                      'Date: ${DateFormat('yyyy-MM-dd HH:mm').format(task['dateTime'])}',
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteTask(index),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
            PostsPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAddTask,
          backgroundColor: Colors.teal,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
