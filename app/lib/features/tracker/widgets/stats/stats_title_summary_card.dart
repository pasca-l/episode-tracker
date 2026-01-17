// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';

class StatsTitleSummaryCard extends StatelessWidget {
  const StatsTitleSummaryCard({
    super.key,
    required this.tracker,
    required this.records,
  });

  final Tracker tracker;
  final List<Record> records;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Text(
              "Stats on titles",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Currently watching: ${records.where((record) => !record.watched).length}',
            ),
            Text(
              'Finished watching: ${records.where((record) => record.watched).length}',
            ),
            Text(
              'Total: ${records.length}',
            ),
          ],
        ),
      ),
    );
  }
}
