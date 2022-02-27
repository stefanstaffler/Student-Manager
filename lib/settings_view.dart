import 'package:flutter/material.dart';

import 'generated/l10n.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S().menu_settings,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
