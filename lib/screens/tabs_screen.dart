import 'package:flutter/material.dart';

import '../widgets/add_edit_task.dart';
import '../widgets/tasks_drawer.dart';
import 'completed_tasks_screen.dart';
import 'favorite_tasks_screen.dart';
import 'pending_tasks_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  static const path = '/tabs';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'page': const PendingTasksScreen(), 'title': 'Pending Tasks'},
    {'page': const CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'page': const FavoriteTasksScreen(), 'title': 'Favorite Tasks'},
  ];

  var _selectedPageIndex = 0;

  void _addNewTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddEditTask(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedPage = _pageDetails[_selectedPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPage['title']),
        actions: _selectedPageIndex == 0
            ? [
                IconButton(
                  onPressed: () => _addNewTask(context),
                  icon: const Icon(Icons.add),
                ),
              ]
            : null,
      ),
      drawer: const TasksDrawer(),
      body: selectedPage['page'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addNewTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        elevation: 24,
        onTap: (index) {
          setState(() => _selectedPageIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle_sharp),
            label: 'Pending Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Completed Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite Tasks',
          ),
        ],
      ),
    );
  }
}
