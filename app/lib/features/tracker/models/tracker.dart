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
    required this.season,
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
  final int season;
  final int episode;
  final DateTime airedFrom;
  final List<String> genre;
  final List<String> related;
  final bool watched;

  factory Record.newRecord() {
    return Record(
      uid: "",
      title: "no title",
      titlePronunciation: "",
      titleEnglish: "",
      season: 1,
      episode: 1,
      airedFrom: DateTime.now(),
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
      season: data["season"] ?? 1,
      episode: data["episode"] ?? 1,
      airedFrom: data["aired_from"].toDate() ?? DateTime.now(),
      genre: List<String>.from(data["genre"] ?? []),
      related: List<String>.from(data["related"] ?? []),
      watched: data["watched"] ?? false,
    );
  }
}
