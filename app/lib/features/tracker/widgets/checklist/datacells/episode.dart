// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';

class ChecklistEpisodeDataCell extends StatelessWidget {
  const ChecklistEpisodeDataCell({
    super.key,
    required this.tracker,
    required this.record,
  });

  final Tracker tracker;
  final Record record;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            if (record.episode.last > 1) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 1),
                content: Text("${record.title}, updated!"),
              ));
              TrackerRepository.updateRecord(
                tracker,
                record,
                episode: [
                  ...record.episode.sublist(0, record.episode.length - 1),
                  record.episode.last - 1
                ],
              );
            }
          },
        ),
        Text((record.episode.last + 1).toString()),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text("${record.title}, updated!"),
            ));
            TrackerRepository.updateRecord(
              tracker,
              record,
              episode: [
                ...record.episode.sublist(0, record.episode.length - 1),
                record.episode.last + 1
              ],
            );
          },
        ),
      ],
    );
  }
}
