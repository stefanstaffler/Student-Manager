import 'package:flutter/material.dart';

import 'constants.dart';
import 'generated/l10n.dart';

class StudentManagerDrawer extends StatelessWidget {
  const StudentManagerDrawer({Key? key, required this.viewChanged})
      : super(key: key);

  final ValueChanged<View> viewChanged;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Text(
                      S().menu_title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(S().menu_marks),
                  onTap: () {
                    viewChanged(View.marks);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(S().menu_tasks),
                  onTap: () {
                    viewChanged(View.tasks);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(S().menu_settings),
            onTap: () {
              viewChanged(View.settings);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
