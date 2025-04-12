// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/utils/character_code.dart';
import 'package:app/features/tracker/widgets/history/searchbar.dart';

class HistoryDatatableWithSearch extends StatefulWidget {
  const HistoryDatatableWithSearch({
    super.key,
    required this.tracker,
    required this.records,
    required this.onRecordTap,
  });

  final Tracker tracker;
  final List<Record> records;
  final Function(Record) onRecordTap;

  @override
  State<HistoryDatatableWithSearch> createState() => _HistoryDatatableWithSearchState();
}

class _HistoryDatatableWithSearchState extends State<HistoryDatatableWithSearch> {
  List<Record> _displayedRecords = [];

  @override
  void initState() {
    super.initState();
    _displayedRecords = widget.records;
  }

  @override
  void didUpdateWidget(HistoryDatatableWithSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.records != widget.records) {
      _displayedRecords = widget.records;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HistorySearchBar(
          records: widget.records,
          onFiltered: (filteredRecords) {
            setState(() {
              _displayedRecords = filteredRecords;
            });
          },
        ),
        SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: HistoryDatatable(
              tracker: widget.tracker,
              records: _displayedRecords,
              onRecordTap: widget.onRecordTap,
            ),
          ),
        ),
      ],
    );
  }
}

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
  bool _sortAscending = false;

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
        widget.records.sort((a, b) => a.episode.last.compareTo(b.episode.last));
      } else {
        widget.records.sort((a, b) => b.episode.last.compareTo(a.episode.last));
      }
    });
  }

  void _onSortAiredFrom(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      if (ascending) {
        widget.records
            .sort((a, b) => a.airedFrom.last.compareTo(b.airedFrom.last));
      } else {
        widget.records
            .sort((a, b) => b.airedFrom.last.compareTo(a.airedFrom.last));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // apply sort initially
    _onSortAiredFrom(_sortColumnIndex, _sortAscending);
  }

  @override
  void didUpdateWidget(HistoryDatatable oldWidget) {
    super.didUpdateWidget(oldWidget);

    // apply sort when refetching new data
    _onSortAiredFrom(_sortColumnIndex, _sortAscending);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
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
            label: Text("Latest season",
                style: TextStyle(fontWeight: FontWeight.bold)),
            numeric: true,
          ),
          DataColumn(
            label:
                Text("Episode", style: TextStyle(fontWeight: FontWeight.bold)),
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
            label:
                Text("Related", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label:
                Text("Watched", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
        rows: widget.records.map<DataRow>((record) {
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
              DataCell(Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: Text(
                    record.titlePronunciation,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ))),
              DataCell(Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: Text(
                    record.titleEnglish,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ))),
              DataCell(Text(record.episode.length.toString())),
              DataCell(Text(record.episode.last.toString())),
              DataCell(Text(record.airedFrom.last.toString().substring(0, 10))),
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
      ),
    );
  }
}
