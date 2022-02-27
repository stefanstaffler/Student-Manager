import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final DismissDirectionCallback dismissDirectionCallback;

  const TaskCard(
      {Key? key, required this.task, required this.dismissDirectionCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(task),
      child: GestureDetector(
        child: Card(
          child: ListTile(
            title: Text(task.subject),
            subtitle: Text("Fällig am " +
                DateFormat("dd.MM.yyyy").format(DateTime.parse(task.date))),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed("/showTask", arguments: task);
        },
      ),
      onDismissed: dismissDirectionCallback,
      direction: DismissDirection.endToStart,
    );
  }
}
