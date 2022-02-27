import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants.dart';
import 'database.dart';
import 'generated/l10n.dart';
import 'mark_detail_view.dart';
import 'student_manager_drawer.dart';
import 'task_detail_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StudentManagerApp());
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
      locale: const Locale("de"),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateTitle: (context) => S().title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(S().title),
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
