import 'package:flutter/material.dart';

import 'constants.dart';

class Task {
  int? id;
  String subject;
  String task;
  String date;
  ValidTaskState taskState;

  Task({
    Key? key,
    this.id,
    required this.subject,
    required this.task,
    required this.date,
    required this.taskState,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "subject": subject,
      "task": task,
      "date": date,
      "taskState": taskState.stateName,
    };
  }

  static Task fromMap(Map<String, Object?> map) {
    return Task(
      id: map["id"] as int,
      subject: map["subject"].toString(),
      task: map["task"].toString(),
      date: map["date"].toString(),
      taskState: ValidTaskState.values.singleWhere(
        (element) => element.stateName == map["taskState"].toString(),
        orElse: () => ValidTaskState.notDoneYet,
      ),
    );
  }
}
