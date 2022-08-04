import 'package:flutter/material.dart';

import '../test_data.dart';
import '../widgets/tasks_list.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(
              label: Text(
                '${TestData.pendingTasks.length} Pending | ${TestData.completedTasks.length} Completed',
              ),
            ),
          ),
          const SizedBox(height: 10),
          TasksList(tasksList: TestData.pendingTasks),
        ],
      ),
    );
  }
}
