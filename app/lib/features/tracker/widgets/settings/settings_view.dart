// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/settings/settings_language.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.tracker});

  final Tracker tracker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 40,
          ),
          child: Column(
            spacing: 10,
            children: [
              SettingsLanguage(),
            ],
          )),
    );
  }
}
