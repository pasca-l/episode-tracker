import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TrackerSettings extends StatelessWidget {
  const TrackerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Tracker Settings"),
        ],
      ),
    );
  }
}
