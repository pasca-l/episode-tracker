// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/utils/tracker.dart';

class FilteredRecordsBuilder extends StatefulWidget {
  const FilteredRecordsBuilder({
    super.key,
    required this.records,
    required this.queryController,
    required this.builder,
  });

  final List<Record> records;
  final TextEditingController queryController;
  final Widget Function(BuildContext context, List<Record> filteredRecords)
      builder;

  @override
  State<FilteredRecordsBuilder> createState() => _FilteredRecordsBuilderState();
}

class _FilteredRecordsBuilderState extends State<FilteredRecordsBuilder> {
  List<Record> _displayedRecords = [];

  void _filterListener() {
    final query = widget.queryController.text;
    setState(() {
      _displayedRecords = RecordUtils.filterRecords(widget.records, query);
    });
  }

  @override
  void initState() {
    super.initState();
    _displayedRecords =
        RecordUtils.filterRecords(widget.records, widget.queryController.text);
    widget.queryController.addListener(_filterListener);
  }

  @override
  void didUpdateWidget(FilteredRecordsBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.records != widget.records) {
      _displayedRecords = RecordUtils.filterRecords(
          widget.records, widget.queryController.text);
    }
    if (oldWidget.queryController != widget.queryController) {
      oldWidget.queryController.removeListener(_filterListener);
      widget.queryController.addListener(_filterListener);
    }
  }

  @override
  void dispose() {
    widget.queryController.removeListener(_filterListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _displayedRecords);
  }
}
