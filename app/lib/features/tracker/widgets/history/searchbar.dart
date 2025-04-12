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

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: SearchBar(
        hintText: 'Search by title, pronunciation, or english title...',
        leading: Icon(Icons.search),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16.0),
        ),
        onChanged: (String query) {
          if (query.isEmpty) {
            onFiltered(records);
            return;
          }

          final lowercaseQuery = query.toLowerCase();
          final filteredRecords = records.where((record) {
            return record.title.toLowerCase().contains(lowercaseQuery) ||
                record.titlePronunciation
                    .toLowerCase()
                    .contains(lowercaseQuery) ||
                record.titleEnglish.toLowerCase().contains(lowercaseQuery);
          }).toList();

          onFiltered(filteredRecords);
        },
      ),
    );
  }
}
