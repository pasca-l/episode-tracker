// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';

class StatsEpisodeSummaryCard extends StatelessWidget {
  const StatsEpisodeSummaryCard({
    super.key,
    required this.tracker,
    required this.records,
  });

  final Tracker tracker;
  final List<Record> records;

  int get totalEpisodes => records.where((record) => record.watched).fold(
      0, (sum, record) => sum + record.episode.fold(0, (sum, ep) => sum + ep));

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
              "Stats on episodes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Total watched: $totalEpisodes',
            ),
          ],
        ),
      ),
    );
  }
}
