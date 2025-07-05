// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';
import 'package:app/features/tracker/widgets/checklist/checklist_view.dart';

class TrackerChecklist extends StatelessWidget {
  const TrackerChecklist({super.key, required this.tracker});

  final Tracker tracker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: StreamBuilder<QuerySnapshot>(
          stream: TrackerRepository.getRecords(tracker),
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            // only show records that is not fully watched
            final List<Record> records = snapshot.data?.docs
                    .map((doc) {
                      return Record.fromFirestore(doc);
                    })
                    .where((record) => record.watched == false)
                    .toList() ??
                [];

            return ChecklistView(tracker: tracker, records: records);
          },
        ),
      ),
    );
  }
}
