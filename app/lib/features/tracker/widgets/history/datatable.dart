// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';

class HistoryDatatable extends StatelessWidget {
  const HistoryDatatable({
    super.key,
    required this.tracker,
    required this.records,
    required this.onRecordTap,
  });

  final Tracker tracker;
  final List<Record> records;
  final Function(Record) onRecordTap;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text("Title", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text(
            "Title pronunciation",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            "Title in english",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text("Season", style: TextStyle(fontWeight: FontWeight.bold)),
          numeric: true,
        ),
        DataColumn(
          label: Text("Episode", style: TextStyle(fontWeight: FontWeight.bold)),
          numeric: true,
        ),
        DataColumn(
          label: Text(
            "Aired from",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text("Genre", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text("Related", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text("Watched", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
      rows:
          records.map<DataRow>((record) {
            return DataRow(
              cells: [
                DataCell(
                  Container(
                    constraints: BoxConstraints(minWidth: 300, maxWidth: 300),
                    child: Text(record.title),
                  ),
                  onTap: () {
                    onRecordTap(record);
                  },
                ),
                DataCell(Text(record.titlePronunciation)),
                DataCell(Text(record.titleEnglish)),
                DataCell(Text(record.season.toString())),
                DataCell(Text(record.episode.toString())),
                DataCell(Text(record.airedFrom.toString().substring(0, 10))),
                DataCell(Text(record.genre.toString())),
                DataCell(Text(record.related.toString())),
                DataCell(
                  Center(
                    child: Icon(
                      record.watched
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}
