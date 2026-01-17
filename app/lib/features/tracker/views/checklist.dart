// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';
import 'package:app/features/tracker/widgets/checklist/checklist_view.dart';

class TrackerChecklist extends StatefulWidget {
  const TrackerChecklist({super.key, required this.tracker});

  final Tracker tracker;

  @override
  State<TrackerChecklist> createState() => _TrackerChecklistState();
}

class _TrackerChecklistState extends State<TrackerChecklist> {
  late final TextEditingController _queryController;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _queryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: StreamBuilder<QuerySnapshot>(
          stream: TrackerRepository.getRecords(widget.tracker),
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
                    .where((record) => !record.watched)
                    .toList() ??
                [];

            return ChecklistView(
              tracker: widget.tracker,
              records: records,
              queryController: _queryController,
            );
          },
        ),
      ),
    );
  }
}
