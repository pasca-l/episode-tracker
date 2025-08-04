// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/checklist/checklist_list.dart';

class ChecklistView extends StatelessWidget {
  const ChecklistView(
      {super.key, required this.tracker, required this.records});

  final Tracker tracker;
  final List<Record> records;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40,
        ),
        child: ChecklistList(tracker: tracker, records: records),
      ),
    );
  }
}
