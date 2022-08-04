import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/tasks_drawer.dart';
import '../widgets/tasks_list.dart';

class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({Key? key}) : super(key: key);

  static const path = '/recycle-bin';

  @override
  Widget build(BuildContext context) {
    final List<Task> removedTasks = [
      Task(title: 'Finals exam', description: 'Study for Finals Exam'),
      Task(title: 'Buy groceries', description: 'Don\'t forget the cheese'),
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Recycle Bin'),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Delete all tasks'),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
        drawer: const TasksDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text('${removedTasks.length} Tasks'),
                ),
              ),
              const SizedBox(height: 10),
              TasksList(tasksList: removedTasks),
            ],
          ),
        ));
  }
}
