// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';

class HistoryDatatable extends StatefulWidget {
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
  State<HistoryDatatable> createState() => _HistoryDatatableState();
}

class _HistoryDatatableState extends State<HistoryDatatable> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void _onSortTitle(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      if (ascending) {
        widget.records.sort(
          (a, b) => a.titlePronunciation.compareTo(b.titlePronunciation),
        );
      } else {
        widget.records.sort(
          (a, b) => b.titlePronunciation.compareTo(a.titlePronunciation),
        );
      }
    });
  }

  void _onSortTitleEnglish(int columnIndex, bool ascending) {
    String sanitizeTitle(String title) {
      return title.replaceAll(RegExp(r'[^\w\s]+'), '').toLowerCase();
    }

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      if (ascending) {
        widget.records.sort(
          (a, b) => sanitizeTitle(
            a.titleEnglish,
          ).compareTo(sanitizeTitle(b.titleEnglish)),
        );
      } else {
        widget.records.sort(
          (a, b) => sanitizeTitle(
            b.titleEnglish,
          ).compareTo(sanitizeTitle(a.titleEnglish)),
        );
      }
    });
  }

  void _onSortEpisode(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      if (ascending) {
        widget.records.sort((a, b) => a.episode.compareTo(b.episode));
      } else {
        widget.records.sort((a, b) => b.episode.compareTo(a.episode));
      }
    });
  }

  void _onSortAiredFrom(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      if (ascending) {
        widget.records.sort((a, b) => a.airedFrom.compareTo(b.airedFrom));
      } else {
        widget.records.sort((a, b) => b.airedFrom.compareTo(a.airedFrom));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAscending,
      columns: [
        DataColumn(
          label: Text("Title", style: TextStyle(fontWeight: FontWeight.bold)),
          onSort: (index, asc) {
            _onSortTitle(index, asc);
          },
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
          onSort: (index, asc) {
            _onSortTitleEnglish(index, asc);
          },
        ),
        DataColumn(
          label: Text("Season", style: TextStyle(fontWeight: FontWeight.bold)),
          numeric: true,
        ),
        DataColumn(
          label: Text("Episode", style: TextStyle(fontWeight: FontWeight.bold)),
          numeric: true,
          onSort: (index, asc) {
            _onSortEpisode(index, asc);
          },
        ),
        DataColumn(
          label: Text(
            "Aired from",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onSort: (index, asc) {
            _onSortAiredFrom(index, asc);
          },
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
          widget.records.map<DataRow>((record) {
            return DataRow(
              cells: [
                DataCell(
                  Container(
                    constraints: BoxConstraints(minWidth: 300, maxWidth: 300),
                    child: Text(record.title),
                  ),
                  onTap: () {
                    widget.onRecordTap(record);
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
