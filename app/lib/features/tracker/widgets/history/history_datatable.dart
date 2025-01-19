import 'package:flutter/material.dart';

import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';

class HistoryDatatable extends StatelessWidget {
  const HistoryDatatable({
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
        DataColumn(label: Text("Season"), numeric: true),
        DataColumn(label: Text("Episode"), numeric: true),
        DataColumn(label: Text("Aired from")),
        DataColumn(label: Text("Genre")),
        DataColumn(label: Text("Related")),
        DataColumn(label: Text("Watched")),
      ],
      rows:
          records.map<DataRow>((record) {
            return DataRow(
              cells: [
                DataCell(
                  Container(
                    constraints: BoxConstraints(minWidth: 350),
                    child: Text(record.title),
                  ),
                ),
                DataCell(Text(record.season.toString())),
                DataCell(Text(record.episode.toString())),
                DataCell(Text(record.airedFrom.toString().substring(0, 10))),
                DataCell(Text(record.genre.toString())),
                DataCell(Text(record.related.toString())),
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
