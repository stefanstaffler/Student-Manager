import 'package:flutter/material.dart';

import 'add_mark_button.dart';
import 'add_task_button.dart';
import 'marks_view.dart';
import 'settings_view.dart';
import 'tasks_view.dart';

final GlobalKey<MarksViewState> marksViewKey = GlobalKey();
final GlobalKey<TasksViewState> tasksViewKey = GlobalKey();

final kAddMarkButton = AddMarkButton(
  marksViewKey: marksViewKey,
);

final kAddTaskButton = AddTaskButton(
  taskViewKey: tasksViewKey,
);

enum View {
  marks,
  tasks,
  settings,
}

extension ViewExtension on View {
  Widget get widget {
    switch (this) {
      case View.marks:
        return MarksView(
          key: marksViewKey,
        );
      case View.tasks:
        return TasksView(
          key: tasksViewKey,
        );
      case View.settings:
        return const SettingsView();
    }
  }
}

enum ViewRoutes {
  addMark,
  editMark,
  showMark,
  addTask,
  editTask,
  showTask,
}

extension ViewRoutesExtension on ViewRoutes {
  String get route {
    switch(this) {
      case ViewRoutes.addMark:
        return "/addMark";
      case ViewRoutes.editMark:
        return "/editMark";
      case ViewRoutes.showMark:
        return "/showMark";
      case ViewRoutes.addTask:
        return "/addTask";
      case ViewRoutes.editTask:
        return "/editTask";
      case ViewRoutes.showTask:
        return "/showTask";
    }
  }
}

enum ViewType {
  add,
  edit,
  show,
}

extension ViewTypeExtension on ViewType {
  String get viewTypeName {
    switch (this) {
      case ViewType.add:
        return "Add";
      case ViewType.edit:
        return "Edit";
      case ViewType.show:
        return "Show";
    }
  }
}

enum ValidMark {
  one,
  two,
  three,
  four,
  five,
}

extension ValidMarkExtension on ValidMark {
  int get value {
    switch (this) {
      case ValidMark.one:
        return 1;
      case ValidMark.two:
        return 2;
      case ValidMark.three:
        return 3;
      case ValidMark.four:
        return 4;
      case ValidMark.five:
        return 5;
    }
  }

  String get markName {
    switch (this) {
      case ValidMark.one:
        return "Sehr gut";
      case ValidMark.two:
        return "Gut";
      case ValidMark.three:
        return "Befriedigend";
      case ValidMark.four:
        return "Genügend";
      case ValidMark.five:
        return "Nicht genügend";
    }
  }
}

enum ValidExamType {
  exam,
  test,
  other,
}

extension ValidExamTypeExtension on ValidExamType {
  String get examName {
    switch (this) {
      case ValidExamType.exam:
        return "Schularbeit";
      case ValidExamType.test:
        return "Test";
      case ValidExamType.other:
        return "Other type";
    }
  }

  String get acronym {
    switch (this) {
      case ValidExamType.exam:
        return "SA";
      case ValidExamType.test:
        return "T";
      case ValidExamType.other:
        return "O";
    }
  }
}

enum ValidTaskState {
  finished,
  partlyDone,
  notDoneYet,
  notDone,
}

extension ValidTaskStateExtension on ValidTaskState {
  String get stateName {
    switch (this) {
      case ValidTaskState.finished:
        return "Abgeschlossen";
      case ValidTaskState.partlyDone:
        return "Teilweise abgeschlossen";
      case ValidTaskState.notDoneYet:
        return "Noch nicht gemacht";
      case ValidTaskState.notDone:
        return "Nicht gemacht";
    }
  }
}

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.deepOrange[500],
  backgroundColor: Colors.orange[100],
  scaffoldBackgroundColor: Colors.orange[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.deepOrange[500],
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange[500],
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 20.0,
    ),
    bodyText2: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    headline1: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
      foregroundColor: MaterialStateProperty.all(Colors.white),
    ),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.orange[100],
  ),
);
