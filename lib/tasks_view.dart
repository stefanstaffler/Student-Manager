import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:easy_localization/easy_localization.dart';

import 'database.dart';
import 'task.dart';
import 'task_card.dart';

class TasksView extends StatefulWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  State<TasksView> createState() => TasksViewState();
}

class TasksViewState extends State<TasksView> {
  final List<Task> _taskList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    loadTasks();
  }

  void loadTasks() {
    StudentManagerDb().database.then((db) async {
      if (db != null) {
        List<Map<String, Object?>> tasksMaps = await db.query("tasks");
        List<Task> tList =
            tasksMaps.map((e) => Task.fromMap(e)).toList(growable: true);
        _addTasksFromDb(tList);
      }
    });
  }

  void _addTasksFromDb(List<Task> tasks) {
    setState(() {
      _taskList.addAll(tasks);
    });
  }

  void addTask(Task task) async {
    Database? db = await StudentManagerDb().database;
    int? id = await db?.insert("tasks", task.toMap());

    if (id != null) {
      task.id = id;
    }

    setState(() {
      _taskList.add(task);
    });
  }

  void addTaskAt(Task task, int index) async {
    Database? db = await StudentManagerDb().database;
    int? id = await db?.insert("tasks", task.toMap());

    if (id != null) {
      task.id = id;
    }

    setState(() {
      _taskList.insert(index, task);
    });
  }

  void removeTask(int index) async {
    Database? db = await StudentManagerDb().database;
    await db
        ?.delete("tasks", where: "id = ?", whereArgs: [_taskList[index].id]);
    setState(() {
      _taskList.removeAt(index);
    });
  }

  void updateTask(Task task) async {
    Database? db = await StudentManagerDb().database;
    await db
        ?.update("tasks", task.toMap(), where: "id = ?", whereArgs: [task.id]);
    setState(() {
      int index = _taskList.indexOf(task);
      _taskList.remove(task);
      _taskList.insert(index, task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "menu_tasks",
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ).tr(),
        Expanded(
          child: ListView.builder(
            itemCount: _taskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                task: _taskList[index],
                dismissDirectionCallback: (direction) {
                  Task taskItem = _taskList[index];

                  removeTask(index);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Task deleted"),
                    action: SnackBarAction(
                      label: "back".tr(),
                      onPressed: () {
                        addTaskAt(taskItem, index);
                      },
                    ),
                  ));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
