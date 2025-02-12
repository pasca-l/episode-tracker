// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/checklist/datacells/episode.dart';
import 'package:app/features/tracker/widgets/checklist/datacells/title.dart';
import 'package:app/features/tracker/widgets/checklist/datacells/watched.dart';

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
          (a, b) => a.titlePronunciation.compareTo(b.titlePronunciation),
        );
      } else {
        widget.records.sort(
          (a, b) => b.titlePronunciation.compareTo(a.titlePronunciation),
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
              DataCell(
                ChecklistTitleDataCell(
                  key: Key(record.uid),
                  tracker: widget.tracker,
                  record: record,
                ),
              ),
              DataCell(
                ChecklistEpisodeDataCell(
                  key: Key(record.uid),
                  tracker: widget.tracker,
                  record: record,
                ),
              ),
              DataCell(
                ChecklistWatchedDataCell(
                  key: Key(record.uid),
                  tracker: widget.tracker,
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
