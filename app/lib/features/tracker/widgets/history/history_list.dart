// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/utils/tracker.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({
    super.key,
    required this.tracker,
    required this.records,
    required this.onRecordTap,
  });

  final Tracker tracker;
  final List<Record> records;
  final Function(Record) onRecordTap;

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  int _sortColumnIndex = 0;
  bool _sortAscending = false;

  void _onSortAiredFrom(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      sortRecordsByAiredFrom(widget.records, ascending);
    });
  }

  @override
  void initState() {
    super.initState();
    // apply sort initially
    _onSortAiredFrom(_sortColumnIndex, _sortAscending);
  }

  @override
  void didUpdateWidget(HistoryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // apply sort when refetching new data
    _onSortAiredFrom(_sortColumnIndex, _sortAscending);
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                record.titleEnglish,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                ),
              ),
              Text(
                'season: ${record.episode.length.toString()}, episode: ${record.episode.last.toString()}, aired from: ${record.airedFrom.last.toString().substring(0, 10)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                ),
              ),
            ],
          ),
          leading: Checkbox(
            value: record.watched,
            onChanged: (_) {},
          ),
          trailing: Icon(Icons.chevron_right),
          onTap: () => widget.onRecordTap(record),
        );
      },
    );
  }
}
