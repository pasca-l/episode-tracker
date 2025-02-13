// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class Tracker {
  const Tracker({required this.uid, required this.owner});

  final String uid;
  final String owner;
}

class Record {
  const Record({
    required this.uid,
    required this.title,
    required this.titlePronunciation,
    required this.titleEnglish,
    required this.episode,
    required this.airedFrom,
    required this.genre,
    required this.related,
    required this.watched,
  });

  final String uid;
  final String title;
  final String titlePronunciation;
  final String titleEnglish;
  final List<int> episode;
  final List<DateTime> airedFrom;
  final List<String> genre;
  final List<String> related;
  final bool watched;

  factory Record.newRecord() {
    return Record(
      uid: "",
      title: "no title",
      titlePronunciation: "",
      titleEnglish: "",
      episode: List<int>.from([1]),
      airedFrom: List<DateTime>.from([DateTime.now()]),
      genre: List<String>.from([]),
      related: List<String>.from([]),
      watched: false,
    );
  }

  factory Record.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;

    return Record(
      uid: doc.id,
      title: data["title"] ?? "no title",
      titlePronunciation: data["title_pronunciation"] ?? "",
      titleEnglish: data["title_english"] ?? "",
      episode: List<int>.from(data["episode"] ?? [1]),
      airedFrom: List<DateTime>.from(
          data["aired_from"].map((date) => date.toDate()) ?? [DateTime.now()]),
      genre: List<String>.from(data["genre"] ?? []),
      related: List<String>.from(data["related"] ?? []),
      watched: data["watched"] ?? false,
    );
  }
}
