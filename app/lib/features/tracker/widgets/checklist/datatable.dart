import 'package:flutter/material.dart';

import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';

class TrackerDatatable extends StatelessWidget {
  const TrackerDatatable({
    super.key,
    required this.tracker,
    required this.records,
  });

  final Tracker tracker;
  final List<Record> records;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text("Title")),
        DataColumn(label: Text("Next episode to watch"), numeric: true),
        DataColumn(label: Text("Finished watching?")),
      ],
      rows:
          records.map<DataRow>((record) {
            return DataRow(
              cells: [
                DataCell(
                  Container(
                    constraints: BoxConstraints(minWidth: 200, maxWidth: 1000),
                    child: Text(record.title),
                  ),
                  onTap: () {},
                ),
                DataCell(Text((record.episode + 1).toString())),
                DataCell(
                  Center(
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
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}
