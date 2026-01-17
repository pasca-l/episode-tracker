// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/history/history_list.dart';
import 'package:app/features/tracker/widgets/shared/filtered_records_builder.dart';
import 'package:app/features/tracker/widgets/shared/searchbar.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({
    super.key,
    required this.tracker,
    required this.records,
    required this.onRecordTap,
    required this.queryController,
  });

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
        child: FilteredRecordsBuilder(
          records: records,
          queryController: queryController,
          builder: (context, filteredRecords) {
            return Column(
              spacing: 20,
              children: [
                SharedSearchbar(
                  controller: queryController,
                ),
                Expanded(
                  child: HistoryList(
                    tracker: tracker,
                    records: filteredRecords,
                    onRecordTap: onRecordTap,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
