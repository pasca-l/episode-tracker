// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Language { japanese, english }

class LanguageNotifier extends StateNotifier<Language> {
  static const String _languageKey = 'language_setting';

  LanguageNotifier() : super(Language.japanese) {
    _loadLanguage();
  }

  bool get isEnglish => state == Language.english;
  bool get isJapanese => state == Language.japanese;

  void setLanguage(Language language) {
    if (state != language) {
      state = language;
      _saveLanguage();
    }
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageIndex = prefs.getInt(_languageKey) ?? 0;
    state = Language.values[languageIndex];
  }

  Future<void> _saveLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_languageKey, state.index);
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, Language>(
  (ref) => LanguageNotifier(),
);
