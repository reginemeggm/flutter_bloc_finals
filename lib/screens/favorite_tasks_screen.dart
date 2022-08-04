import 'package:flutter/material.dart';

import '../models/task.dart';
import '../test_data.dart';
import '../widgets/tasks_list.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasksList = TestData.favoriteTasks;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(
              label: Text('${tasksList.length} Tasks'),
            ),
          ),
          const SizedBox(height: 10),
          TasksList(tasksList: tasksList),
        ],
      ),
    );
  }
}
