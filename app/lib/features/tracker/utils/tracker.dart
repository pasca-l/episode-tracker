import 'package:app/features/tracker/models/tracker.dart';

List<Record> filterRecords(List<Record> records, String query) {
  if (query.isEmpty) {
    return records;
  }

  final lowercaseQuery = query.toLowerCase();
  return records.where((record) {
    return record.title.toLowerCase().contains(lowercaseQuery) ||
        record.titlePronunciation.toLowerCase().contains(lowercaseQuery) ||
        record.titleEnglish.toLowerCase().contains(lowercaseQuery);
  }).toList();
}
