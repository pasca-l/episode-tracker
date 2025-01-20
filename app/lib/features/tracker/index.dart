// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';
import 'package:app/features/tracker/views/checklist.dart';
import 'package:app/features/tracker/views/history.dart';
import 'package:app/features/tracker/views/settings.dart';
import 'package:app/features/tracker/views/stats.dart';

class TrackerPage extends StatelessWidget {
  TrackerPage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Tracker"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: FutureBuilder<Tracker>(
            future: TrackerRepository.getTracker(user),
            builder: (BuildContext context, AsyncSnapshot<Tracker> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData) {
                return Center(child: Text("Error: no tracker found"));
              }

              return TabBarView(
                children: [
                  TrackerChecklist(tracker: snapshot.data!),
                  TrackerHistory(tracker: snapshot.data!),
                  const TrackerStats(),
                  const TrackerSettings(),
                ],
              );
            },
          ),
          bottomNavigationBar: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.checklist)),
              Tab(icon: Icon(Icons.history)),
              Tab(icon: Icon(Icons.insights)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
        ),
      ),
    );
  }
}
