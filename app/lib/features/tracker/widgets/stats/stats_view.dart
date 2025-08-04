// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/stats/stats_episode_summary_card.dart';
import 'package:app/features/tracker/widgets/stats/stats_title_summary_card.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key, required this.tracker, required this.records});

  final Tracker tracker;
  final List<Record> records;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 40,
          ),
          child: Column(
            spacing: 10,
            children: [
              StatsTitleSummaryCard(tracker: tracker, records: records),
              StatsEpisodeSummaryCard(tracker: tracker, records: records),
            ],
          )),
    );
  }
}
