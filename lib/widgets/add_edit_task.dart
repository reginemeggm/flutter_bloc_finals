import 'package:flutter/material.dart';

import '../models/task.dart';

class AddEditTask extends StatefulWidget {
  final Task? task;

  const AddEditTask({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  late String _title;
  late String _description;

  @override
  void initState() {
    final task = widget.task;

    if (task != null) {
      _title = task.title;
      _description = task.description;
    } else {
      _title = '';
      _description = '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      child: Form(
        child: Column(
          children: [
            Text(
              widget.task == null ? 'Add Task' : 'Edit Task',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: _title,
              autofocus: true,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Can\'t be empty';
                }
                return null;
              },
              onChanged: (text) => setState(() => _title = text),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _description,
              decoration: const InputDecoration(
                label: Text('Description'),
                border: OutlineInputBorder(),
              ),
              minLines: 3,
              maxLines: 5,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Can\'t be empty';
                }
                return null;
              },
              onChanged: (text) => setState(() => _description = text),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _title.isNotEmpty && _description.isNotEmpty
                      ? () {
                          Navigator.pop(context);
                        }
                      : null,
                  child: widget.task == null
                      ? const Text('Add')
                      : const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
