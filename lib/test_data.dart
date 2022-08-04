import 'models/task.dart';

class TestData {
  static const bool isDarkTheme = false;

  static final List<Task> pendingTasks = [
    Task(
      title: 'Pending Task 1',
      description: 'Pending Task 1 Description',
    ),
    Task(
      title: 'Pending Task 2',
      description: 'Pending Task 2 Description',
      isFavorite: true,
    ),
    Task(
      title: 'Pending Task 3',
      description: 'Pending Task 3 Description',
    ),
  ];

  static final List<Task> completedTasks = [
    Task(
      title: 'Done Task 1',
      description: 'Completed Task 1 Description',
      isDone: true,
    ),
    Task(
      title: 'Done Task 2',
      description: 'Completed Task 2 Description',
      isDone: true,
      isFavorite: true,
    ),
  ];

  static final List<Task> removedTasks = [
    Task(
      title: 'Removed Task 1',
      description: 'Removed Task 1 Description',
    ),
    Task(
      title: 'Removed Task 2',
      description: 'Removed Task 2 Description',
    ),
  ];

  static final List<Task> favoriteTasks = [
    Task(
      title: 'Pending Task 2',
      description: 'Pending Task 2 Description',
      isFavorite: true,
    ),
    Task(
      title: 'Done Task 2',
      description: 'Completed Task 2 Description',
      isDone: true,
      isFavorite: true,
    ),
  ];
}
