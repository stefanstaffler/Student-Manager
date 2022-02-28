
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'database.dart';
import 'mark_detail_view.dart';
import 'student_manager_drawer.dart';
import 'task_detail_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("de"),
        Locale("en"),
      ],
      path: "assets/translations",
      useOnlyLangCode: true,
      fallbackLocale: const Locale("en"),
      child: const StudentManagerApp(),
    ),
  );
}

class StudentManagerApp extends StatefulWidget {
  const StudentManagerApp({Key? key}) : super(key: key);

  @override
  State<StudentManagerApp> createState() => _StudentManagerAppState();
}

class _StudentManagerAppState extends State<StudentManagerApp> {
  View _view = View.marks;
  Widget? _floatingButton = kAddMarkButton;

  @override
  void dispose() {
    StudentManagerDb().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: "title".tr(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("title").tr(),
        ),
        drawer: StudentManagerDrawer(
          viewChanged: (View value) {
            setState(() {
              _view = value;

              switch (value) {
                case View.marks:
                  _floatingButton = kAddMarkButton;
                  break;
                case View.tasks:
                  _floatingButton = kAddTaskButton;
                  break;
                default:
                  _floatingButton = null;
                  break;
              }
            });
          },
        ),
        body: SafeArea(
          child: _view.widget,
        ),
        floatingActionButton: _floatingButton,
      ),
      routes: {
        ViewRoutes.addMark.route: (context) => const MarkDetailView(
              viewType: ViewType.add,
            ),
        ViewRoutes.showMark.route: (context) => const MarkDetailView(
              viewType: ViewType.show,
            ),
        ViewRoutes.editMark.route: (context) => const MarkDetailView(
              viewType: ViewType.edit,
            ),
        ViewRoutes.addTask.route: (context) => const TaskDetailView(
              viewType: ViewType.add,
            ),
        ViewRoutes.showTask.route: (context) => const TaskDetailView(
              viewType: ViewType.show,
            ),
        ViewRoutes.editTask.route: (context) => const TaskDetailView(
              viewType: ViewType.edit,
            ),
      },
      theme: kLightTheme,
    );
  }
}
