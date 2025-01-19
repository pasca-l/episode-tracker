import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';

import 'package:app/features/tracker/widgets/checklist/checklist_datatable.dart';

class TrackerChecklist extends StatelessWidget {
  const TrackerChecklist({super.key, required this.tracker});

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

              // only show records that is not fully watched
              final List<Record> records =
                  snapshot.data?.docs
                      .map((doc) {
                        return Record.fromFirestore(doc);
                      })
                      .where((record) => record.watched == false)
                      .toList() ??
                  [];

              return ChecklistDatatable(tracker: tracker, records: records);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "add record",
        onPressed: () {
          TrackerRepository.addRecord(tracker);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
