// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/utils/character_code.dart';

class RecordUtils {
  static void sortRecordsByTitle(List<Record> records, bool ascending) {
    if (ascending) {
      records.sort((a, b) => JapaneseCharacterCode.compare(
            JapaneseCharacterCode.sanitize(a.titlePronunciation),
            JapaneseCharacterCode.sanitize(b.titlePronunciation),
          ));
    } else {
      records.sort((a, b) => JapaneseCharacterCode.compare(
            JapaneseCharacterCode.sanitize(b.titlePronunciation),
            JapaneseCharacterCode.sanitize(a.titlePronunciation),
          ));
    }
  }

  static void sortRecordsByEnglishTitle(List<Record> records, bool ascending) {
    String sanitize(String title) {
      return title.replaceAll(RegExp(r'[^\w\s]+'), '').toLowerCase();
    }

    if (ascending) {
      records.sort((a, b) =>
          sanitize(a.titleEnglish).compareTo(sanitize(b.titleEnglish)));
    } else {
      records.sort((a, b) =>
          sanitize(b.titleEnglish).compareTo(sanitize(a.titleEnglish)));
    }
  }

  static void sortRecordsByEpisode(List<Record> records, bool ascending) {
    if (ascending) {
      records.sort((a, b) => a.episode.last.compareTo(b.episode.last));
    } else {
      records.sort((a, b) => b.episode.last.compareTo(a.episode.last));
    }
  }

  static void sortRecordsByAiredFrom(List<Record> records, bool ascending) {
    if (ascending) {
      records.sort((a, b) => a.airedFrom.last.compareTo(b.airedFrom.last));
    } else {
      records.sort((a, b) => b.airedFrom.last.compareTo(a.airedFrom.last));
    }
  }

  static List<Record> filterRecords(List<Record> records, String query) {
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
}
