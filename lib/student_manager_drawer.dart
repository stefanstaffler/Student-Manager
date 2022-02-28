import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'constants.dart';

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
                      "menu_title",
                      style: Theme.of(context).textTheme.headline1,
                    ).tr(),
                  ),
                ),
                ListTile(
                  title: const Text("menu_marks").tr(),
                  onTap: () {
                    viewChanged(View.marks);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text("menu_tasks").tr(),
                  onTap: () {
                    viewChanged(View.tasks);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("menu_settings").tr(),
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
