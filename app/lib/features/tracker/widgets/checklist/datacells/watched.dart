// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';

class ChecklistWatchedDataCell extends StatelessWidget {
  const ChecklistWatchedDataCell({
    super.key,
    required this.tracker,
    required this.record,
  });

  final Tracker tracker;
  final Record record;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Checkbox(
        value: record.watched,
        onChanged: (bool? value) {
          TrackerRepository.updateRecord(
            tracker,
            record,
            watched: !record.watched,
          );
        },
      ),
    );
  }
}
