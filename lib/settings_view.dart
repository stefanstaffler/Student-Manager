import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Locale? _language;

  @override
  Widget build(BuildContext context) {
    _language = Localizations.localeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "menu_settings",
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ).tr(),
        Expanded(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<Locale>(
                    hint: const Text("language_hint").tr(),
                    items: List.generate(
                      context.supportedLocales.length,
                      (index) => DropdownMenuItem(
                        child: Text(context.supportedLocales
                            .elementAt(index)
                            .toString()),
                        value: context.supportedLocales.elementAt(index),
                      ),
                    ),
                    value: _language,
                    onChanged: (Locale? value) {
                      _language = value!;
                      context.setLocale(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
