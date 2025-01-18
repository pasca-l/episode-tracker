import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';

import 'package:app/features/tracker/widgets/checklist/datatable.dart';

class TrackerChecklist extends StatelessWidget {
  TrackerChecklist({super.key, required this.tracker});

  final Tracker tracker;

  final user = FirebaseAuth.instance.currentUser;

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

              return TrackerDatatable(tracker: tracker, records: records);
            },
          ),
        ),
      ),
    );
  }
}
