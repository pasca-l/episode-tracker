// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/history/history_datatable_with_search.dart';

class HistoryView extends StatelessWidget {
  const HistoryView(
      {super.key,
      required this.tracker,
      required this.records,
      required this.onRecordTap,
      required this.queryController});

  final Tracker tracker;
  final List<Record> records;
  final Function(Record) onRecordTap;
  final TextEditingController queryController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
        child: HistoryDatatableWithSearch(
          tracker: tracker,
          records: records,
          queryController: queryController,
          onRecordTap: onRecordTap,
        ),
      ),
    );
  }
}
