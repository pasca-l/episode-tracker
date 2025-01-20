// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';
import 'package:app/features/tracker/widgets/history/history_datatable.dart';

class TrackerHistory extends StatelessWidget {
  const TrackerHistory({super.key, required this.tracker});

  final Tracker tracker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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

              final List<Record> records =
                  snapshot.data?.docs.map((doc) {
                    return Record.fromFirestore(doc);
                  }).toList() ??
                  [];
              records.sort((a, b) => b.airedFrom.compareTo(a.airedFrom));

              return HistoryDatatable(tracker: tracker, records: records);
            },
          ),
        ),
      ),
    );
  }
}
