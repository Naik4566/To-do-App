# To-Do App

This is a simple To-Do App built with **Flutter**. It allows users to manage tasks, mark them as completed, and delete tasks. The app supports **light** and **dark modes** and stores tasks using **SharedPreferences** for persistent storage.

## Features

- **Task Management**: Create, update, and delete tasks.
- **Date and Time Picker**: Choose a date and time when adding a new task.
- **Theme Support**: Toggle between light and dark modes.
- **Persistent Storage**: Store tasks using SharedPreferences, so tasks persist even after closing the app.
- **Responsive UI**: The app uses `TabBar` to switch between the To-Do list and a Posts page.


### View Posts

- **Fetch Posts**: Fetch a list of posts from the [JSONPlaceholder API](https://jsonplaceholder.typicode.com/posts).
- **Filter by User ID**: Search and filter posts by `User ID`.
- **Detailed View**: Posts are displayed with their ID, title, body, and associated `User ID`.
- **Error Handling**: Handles API errors gracefully and displays appropriate messages.

### Theme Support

- **Light and Dark Modes**: Toggle between light and dark themes using the icon in the top-right corner.

## Screenshots

Include some screenshots of the app here:

- **Home Page (To-Do List)**  
  ![Home Page](https://github.com/user-attachments/assets/5a2c358e-9b10-43b1-81d5-4cfb5ff2cbae,https://github.com/user-attachments/assets/fc7adba5-6bea-400b-8e45-c82952762744)  

- **Add Task Page** 
  ![Add Task Page](https://github.com/user-attachments/assets/423ecac3-d1d8-4ed4-8123-b6a0db0a54f0)  

- **Posts Page**  
  ![Posts Page](https://github.com/user-attachments/assets/be0533fc-bf8c-46f8-aea2-6aada53d2b55)

  ## Code Explanation

**main.dart**

Initializes the app with light and dark theme toggle functionality.
Sets up the HomePage as the main entry point.

**home_page.dart**

- **To-Do List**: Displays tasks with options to mark as completed or delete.
- **Tabs**: Provides navigation between the To-Do list and Posts page.
- **Floating Action Button**: Opens the TodoPage to add a new task.

**todo_page.dart**

- **Add Task**: Users can add a new task with a title, subject, and due date using date and time pickers.
Tasks are saved to local storage via SharedPreferences.

**posts_page.dart**

- **Fetch Posts**: Fetches posts from the JSONPlaceholder API and displays them in a scrollable list.
- **Search and Filter**: Users can filter posts by entering a User ID.
Error Handling: Displays a SnackBar in case of API errors or no internet connection.

## Dependencies

- **flutter**: SDK for building cross-platform apps.
- **http**: For making API requests.
- **shared_preferences**: For local storage.
- **intl**: For date and time formatting.

## API Used
This app fetches posts from the JSONPlaceholder API, a free REST API for testing and prototyping.

How to Use
Manage Tasks:

Use the To-Do List tab to view, mark as completed, or delete tasks.
Click the Add Task button to add a new task.

**View Posts:**

Use the Posts tab to view posts fetched from the API.
Use the search bar to filter posts by User ID.

**Toggle Theme:**

Use the theme toggle button in the top-right corner to switch between light and dark themes.