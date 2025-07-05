// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';
import 'package:app/features/tracker/widgets/history/history_drawer.dart';
import 'package:app/features/tracker/widgets/history/history_view.dart';

class TrackerHistory extends StatefulWidget {
  const TrackerHistory({super.key, required this.tracker});

  final Tracker tracker;

  @override
  State<TrackerHistory> createState() => _TrackerHistoryState();
}

class _TrackerHistoryState extends State<TrackerHistory> {
  Record? _selectedRecord;
  late final TextEditingController _queryController;

  Function(Record) _onRecordTap(BuildContext context) {
    return (Record record) {
      setState(() {
        _selectedRecord = record;
      });

      // ensures setState is completed before opening the drawer
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scaffold.of(context).openEndDrawer();
      });
    };
  }

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

            final List<Record> records = snapshot.data?.docs.map((doc) {
                  return Record.fromFirestore(doc);
                }).toList() ??
                [];

            return HistoryView(
              tracker: widget.tracker,
              records: records,
              queryController: _queryController,
              onRecordTap: _onRecordTap(context),
            );
          },
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
            if (context.mounted) {
              _onRecordTap(context)(record);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 1),
                content: Text("new record created!"),
              ));
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
