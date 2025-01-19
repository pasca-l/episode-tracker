import 'package:flutter/material.dart';

import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';

import 'package:app/features/tracker/widgets/checklist/checklist_dialog.dart';

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
    return DataTable(
      columns: [
        DataColumn(label: Text("Title")),
        DataColumn(label: Text("Next episode")),
        DataColumn(label: Text("Watched?")),
      ],
      rows:
          records.map<DataRow>((record) {
            return DataRow(
              cells: [
                DataCell(
                  Container(
                    constraints: BoxConstraints(minWidth: 200),
                    child: Text(record.title),
                  ),
                  onTap: () {
                    showChecklistDialog(context, tracker, record);
                  },
                ),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (record.episode > 1) {
                            TrackerRepository.updateRecord(
                              tracker,
                              record,
                              episode: record.episode - 1,
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text((record.episode + 1).toString()),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          TrackerRepository.updateRecord(
                            tracker,
                            record,
                            episode: record.episode + 1,
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
