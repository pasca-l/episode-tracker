// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';
import 'package:app/features/tracker/widgets/history/datatable.dart';
import 'package:app/features/tracker/widgets/history/drawer.dart';

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

              final List<Record> records = snapshot.data?.docs.map((doc) {
                    return Record.fromFirestore(doc);
                  }).toList() ??
                  [];

              return Padding(
                padding: EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 40),
                  child: HistoryDatatableWithSearch(
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
                  ),
                ),
              );
            },
          ),
        ),
      ),
      endDrawer: _selectedRecord != null
          ? HistoryDrawer(tracker: widget.tracker, record: _selectedRecord!)
          : null,
      floatingActionButton: Builder(
        builder: (BuildContext context) => FloatingActionButton(
          tooltip: "add record",
          onPressed: () async {
            final record = await TrackerRepository.addRecord(widget.tracker);
            setState(() {
              _selectedRecord = record;
            });

            // ensure setState is completed before opening the drawer
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Scaffold.of(context).openEndDrawer();
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
