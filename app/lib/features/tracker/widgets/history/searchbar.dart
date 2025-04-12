// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';

class HistorySearchBar extends StatelessWidget {
  const HistorySearchBar({
    super.key,
    required this.records,
    required this.onFiltered,
  });

  final List<Record> records;
  final Function(List<Record>) onFiltered;

  void _filterRecords(String query) {
    if (query.isEmpty) {
      onFiltered(records);
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    final filteredRecords = records.where((record) {
      return record.title.toLowerCase().contains(lowercaseQuery) ||
          record.titlePronunciation.toLowerCase().contains(lowercaseQuery) ||
          record.titleEnglish.toLowerCase().contains(lowercaseQuery);
    }).toList();

    onFiltered(filteredRecords);
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search by title, pronunciation, or english title...',
      leading: Icon(Icons.search),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 16.0),
      ),
      onChanged: _filterRecords,
    );
  }
}
