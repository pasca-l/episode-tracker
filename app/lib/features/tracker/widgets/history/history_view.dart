// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/utils/tracker.dart';
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/history/history_list.dart';
import 'package:app/features/tracker/widgets/history/history_searchbar.dart';

class HistoryView extends StatefulWidget {
  const HistoryView(
      {super.key,
      required this.tracker,
      required this.records,
      required this.onRecordTap,
      required this.queryController});

  final Tracker tracker;
  final List<Record> records;
  final Function(Record) onRecordTap;
  final TextEditingController queryController;

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<Record> _displayedRecords = [];

  void _filterListener() {
    final query = widget.queryController.text;
    setState(() {
      _displayedRecords = filterRecords(widget.records, query);
    });
  }

  @override
  void initState() {
    super.initState();
    _displayedRecords =
        filterRecords(widget.records, widget.queryController.text);
    widget.queryController.addListener(_filterListener);
  }

  @override
  void didUpdateWidget(HistoryView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.records != widget.records) {
      _displayedRecords =
          filterRecords(widget.records, widget.queryController.text);
    }
    if (oldWidget.queryController.text != widget.queryController.text) {
      oldWidget.queryController.removeListener(_filterListener);
      widget.queryController.addListener(_filterListener);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.queryController.removeListener(_filterListener);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
        child: Column(
          spacing: 20,
          children: [
            HistorySearchbar(
              controller: widget.queryController,
            ),
            Expanded(
              child: HistoryList(
                tracker: widget.tracker,
                records: _displayedRecords,
                onRecordTap: widget.onRecordTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
