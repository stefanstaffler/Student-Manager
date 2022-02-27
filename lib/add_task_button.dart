import 'package:flutter/material.dart';

import 'task.dart';
import 'tasks_view.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({Key? key, required this.taskViewKey}) : super(key: key);

  final GlobalKey<TasksViewState> taskViewKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        final task = await Navigator.pushNamed(context, "/addTask");
        if (task != null) {
          taskViewKey.currentState?.addTask(task as Task);
        }
      },
    );
  }
}
