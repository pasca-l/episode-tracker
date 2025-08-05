// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/settings/settings_view.dart';

class TrackerSettings extends StatelessWidget {
  const TrackerSettings({super.key, required this.tracker});

  final Tracker tracker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SettingsView(tracker: tracker),
      ),
    );
  }
}
