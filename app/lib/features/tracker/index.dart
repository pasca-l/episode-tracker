// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:app/features/authentication/widgets/drawer.dart';
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';
import 'package:app/features/tracker/views/checklist.dart';
import 'package:app/features/tracker/views/history.dart';
import 'package:app/features/tracker/views/settings.dart';
import 'package:app/features/tracker/views/stats.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Tracker"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.checklist), text: "Checklist"),
                Tab(icon: Icon(Icons.history), text: "History"),
                Tab(icon: Icon(Icons.insights), text: "Statistics"),
                Tab(icon: Icon(Icons.settings), text: "Settings"),
              ],
            ),
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
                  TrackerStats(tracker: snapshot.data!),
                  const TrackerSettings(),
                ],
              );
            },
          ),
          drawer: AuthenticationDrawer(user: user),
        ),
      ),
    );
  }
}
