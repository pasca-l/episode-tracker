// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/checklist/datacells/episode.dart';
import 'package:app/features/tracker/widgets/checklist/datacells/title.dart';
import 'package:app/features/tracker/widgets/checklist/datacells/watched.dart';
import 'package:app/features/tracker/widgets/checklist/dialog.dart';

class ChecklistDatatable extends StatelessWidget {
  const ChecklistDatatable({
    super.key,
    required this.tracker,
    required this.records,
  });

  final Tracker tracker;
  final List<Record> records;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Title", style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          // TODO: add onSort
          DataColumn(
            label: Text(
              "Next episode",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          DataColumn(
            label: Text(
              "Watched?",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
        rows:
            records.map<DataRow>((record) {
              return DataRow(
                cells: [
                  DataCell(
                    ChecklistTitleDataCell(
                      key: Key(record.uid),
                      tracker: tracker,
                      record: record,
                    ),
                    onTap: () {
                      showChecklistDialog(context, tracker, record);
                    },
                  ),
                  DataCell(
                    ChecklistEpisodeDataCell(
                      key: Key(record.uid),
                      tracker: tracker,
                      record: record,
                    ),
                  ),
                  DataCell(
                    ChecklistWatchedDataCell(
                      key: Key(record.uid),
                      tracker: tracker,
                      record: record,
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
