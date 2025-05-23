// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';

class TrackerRepository {
  static Future<Tracker> getTracker(User? user) async {
    if (user == null) {
      throw Exception("user is null");
    }

    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
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

  static Future<Record> addRecord(Tracker tracker) async {
    Record record = Record.newRecord();

    DocumentReference docRef = await FirebaseFirestore.instance
        .collection("trackers")
        .doc(tracker.uid)
        .collection("records")
        .add({
      "title": record.title,
      "title_pronunciation": record.titlePronunciation,
      "title_english": record.titleEnglish,
      "episode": record.episode,
      "aired_from":
          record.airedFrom.map((date) => Timestamp.fromDate(date)).toList(),
      "genre": record.genre,
      "related": record.related,
      "watched": record.watched,
    }).catchError(
      (e) => throw Exception("failed to add record, with error: $e"),
    );

    return Record.fromFirestore(await docRef.get());
  }

  static Future<void> updateRecord(
    Tracker tracker,
    Record record, {
    String? title,
    String? titlePronunciation,
    String? titleEnglish,
    List<int>? episode,
    List<DateTime>? airedFrom,
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
      "title_pronunciation": titlePronunciation ?? record.titlePronunciation,
      "title_english": titleEnglish ?? record.titleEnglish,
      "episode": episode ?? record.episode,
      "aired_from": airedFrom ??
          record.airedFrom.map((date) => Timestamp.fromDate(date)).toList(),
      "genre": genre ?? record.genre,
      "related": related ?? record.related,
      "watched": watched ?? record.watched,
    });
  }

  static Future<void> deleteRecord(Tracker tracker, Record record) {
    return FirebaseFirestore.instance
        .collection("trackers")
        .doc(tracker.uid)
        .collection("records")
        .doc(record.uid)
        .delete()
        .catchError(
          (e) => throw Exception(
            "failed to delete record: ${record.uid}, with error: $e",
          ),
        );
  }
}
