// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';
import 'package:app/features/tracker/utils/tracker.dart';
import 'package:app/shared/widgets/snackbar.dart';

class ChecklistList extends StatefulWidget {
  const ChecklistList({
    super.key,
    required this.tracker,
    required this.records,
  });

  final Tracker tracker;
  final List<Record> records;
  @override
  State<ChecklistList> createState() => _ChecklistListState();
}

class _ChecklistListState extends State<ChecklistList> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void _onSortTitle(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      sortRecordsByTitle(widget.records, ascending);
    });
  }

  @override
  void initState() {
    super.initState();
    // apply sort initially
    _onSortTitle(_sortColumnIndex, _sortAscending);
  }

  @override
  void didUpdateWidget(ChecklistList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // apply sort when refetching new data
    _onSortTitle(_sortColumnIndex, _sortAscending);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.records.length,
      separatorBuilder: (context, index) => Divider(
        height: 0,
      ),
      itemBuilder: (context, index) {
        final record = widget.records[index];
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(right: 0),
          title: Text(
            record.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text("Next episode: ${record.episode.last + 1}"),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () {
                  if (record.episode.last <= 1) {
                    return;
                  }
                  TrackerRepository.updateRecord(
                    widget.tracker,
                    record,
                    episode: [
                      ...record.episode.sublist(0, record.episode.length - 1),
                      record.episode.last - 1
                    ],
                  );
                  SnackbarHelper.show(context, "\"${record.title}\", updated!");
                },
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () {
                  TrackerRepository.updateRecord(
                    widget.tracker,
                    record,
                    episode: [
                      ...record.episode.sublist(0, record.episode.length - 1),
                      record.episode.last + 1
                    ],
                  );
                  SnackbarHelper.show(context, "\"${record.title}\", updated!");
                },
              ),
            ],
          ),
          trailing: Checkbox(
            value: record.watched,
            onChanged: (_) {
              TrackerRepository.updateRecord(
                widget.tracker,
                record,
                watched: !record.watched,
              );
              SnackbarHelper.show(context, "\"${record.title}\", watched!");
            },
          ),
        );
      },
    );
  }
}
