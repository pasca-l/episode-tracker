import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/features/tracker/models/tracker.dart';

class TrackerRepository {
  static Future<Tracker> getTracker(User? user) async {
    if (user == null) {
      throw Exception("user is null");
    }

    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection("trackers")
            .where("owner", isEqualTo: user.uid)
            .get();

    if (snapshot.docs.isNotEmpty) {
      // takes first document, because only one should be available
      DocumentSnapshot doc = snapshot.docs.first;

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Tracker(uid: doc.id, owner: data["owner"]);
    } else {
      throw Exception("no document found");
    }
  }

  static Stream<QuerySnapshot> getRecords(Tracker tracker) {
    return FirebaseFirestore.instance
        .collection("trackers")
        .doc(tracker.uid)
        .collection("records")
        .snapshots();
  }

  static Future<void> updateRecord(
    Tracker tracker,
    Record record, {
    String? title,
    int? season,
    int? episode,
    DateTime? airedFrom,
    List<String>? genre,
    List<String>? related,
    bool? watched,
  }) {
    return FirebaseFirestore.instance
        .collection("trackers")
        .doc(tracker.uid)
        .collection("records")
        .doc(record.uid)
        .update({
          "title": title ?? record.title,
          "season": season ?? record.season,
          "episode": episode ?? record.episode,
          "aired_from":
              airedFrom != null
                  ? Timestamp.fromDate(airedFrom)
                  : Timestamp.fromDate(record.airedFrom),
          "genre": genre ?? record.genre,
          "related": related ?? record.related,
          "watched": watched ?? record.watched,
        });
  }
}
