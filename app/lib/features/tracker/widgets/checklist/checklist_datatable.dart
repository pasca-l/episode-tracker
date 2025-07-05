// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';
import 'package:app/features/tracker/utils/character_code.dart';

class ChecklistDatatable extends StatefulWidget {
  const ChecklistDatatable({
    super.key,
    required this.tracker,
    required this.records,
  });

  final Tracker tracker;
  final List<Record> records;
  @override
  State<ChecklistDatatable> createState() => _ChecklistDatatableState();
}

class _ChecklistDatatableState extends State<ChecklistDatatable> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void _onSortTitle(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      if (ascending) {
        widget.records.sort(
          (a, b) => JapaneseCharacterCode.compare(
            JapaneseCharacterCode.sanitize(a.titlePronunciation),
            JapaneseCharacterCode.sanitize(b.titlePronunciation),
          ),
        );
      } else {
        widget.records.sort(
          (a, b) => JapaneseCharacterCode.compare(
            JapaneseCharacterCode.sanitize(b.titlePronunciation),
            JapaneseCharacterCode.sanitize(a.titlePronunciation),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // apply sort initially
    _onSortTitle(_sortColumnIndex, _sortAscending);
  }

  @override
  void didUpdateWidget(ChecklistDatatable oldWidget) {
    super.didUpdateWidget(oldWidget);
    // apply sort when refetching new data
    _onSortTitle(_sortColumnIndex, _sortAscending);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 15,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
              label: Expanded(
                child: Text(
                  "Title",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Next episode",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                "Watched?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: widget.records.map<DataRow>((record) {
            return DataRow(
              cells: [
                DataCell(Container(
                  constraints: BoxConstraints(minWidth: 180, maxWidth: 180),
                  child: Text(record.title),
                )),
                DataCell(Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (record.episode.last > 1) {
                          TrackerRepository.updateRecord(
                            widget.tracker,
                            record,
                            episode: [
                              ...record.episode
                                  .sublist(0, record.episode.length - 1),
                              record.episode.last - 1
                            ],
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text("\"${record.title}\", updated!"),
                          ));
                        }
                      },
                    ),
                    Text((record.episode.last + 1).toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        TrackerRepository.updateRecord(
                          widget.tracker,
                          record,
                          episode: [
                            ...record.episode
                                .sublist(0, record.episode.length - 1),
                            record.episode.last + 1
                          ],
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("\"${record.title}\", updated!"),
                        ));
                      },
                    ),
                  ],
                )),
                DataCell(
                  Center(
                    child: Checkbox(
                      value: record.watched,
                      onChanged: (_) {
                        TrackerRepository.updateRecord(
                          widget.tracker,
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
        ),
      ),
    );
  }
}
