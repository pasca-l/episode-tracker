// Flutter imports:
import 'package:app/features/tracker/widgets/history/drawer.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';
import 'package:app/features/tracker/widgets/history/datatable.dart';

class TrackerHistory extends StatefulWidget {
  const TrackerHistory({super.key, required this.tracker});

  final Tracker tracker;

  @override
  State<TrackerHistory> createState() => _TrackerHistoryState();
}

class _TrackerHistoryState extends State<TrackerHistory> {
  Record? _selectedRecord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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

              final List<Record> records =
                  snapshot.data?.docs.map((doc) {
                    return Record.fromFirestore(doc);
                  }).toList() ??
                  [];
              records.sort((a, b) => b.airedFrom.compareTo(a.airedFrom));

              return HistoryDatatable(
                tracker: widget.tracker,
                records: records,
                onRecordTap: (record) {
                  setState(() {
                    _selectedRecord = record;
                  });
                  // ensures setState is completed before opening the drawer
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Scaffold.of(context).openEndDrawer();
                  });
                },
              );
            },
          ),
        ),
      ),
      endDrawer:
          _selectedRecord != null
              ? HistoryDrawer(tracker: widget.tracker, record: _selectedRecord!)
              : null,
      floatingActionButton: FloatingActionButton(
        tooltip: "add record",
        onPressed: () {
          TrackerRepository.addRecord(widget.tracker);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
