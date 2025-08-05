// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

enum Language { japanese, english }

class LanguageProvider extends ChangeNotifier {
  Language _language = Language.japanese;
  static const String _languageKey = 'language_setting';

  Language get language => _language;
  bool get isEnglish => _language == Language.english;
  bool get isJapanese => _language == Language.japanese;

  LanguageProvider() {
    _loadLanguage();
  }

  void toggleLanguage() {
    _language =
        _language == Language.japanese ? Language.english : Language.japanese;
    _saveLanguage();
    notifyListeners();
  }

  void setLanguage(Language language) {
    if (_language != language) {
      _language = language;
      _saveLanguage();
      notifyListeners();
    }
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageIndex = prefs.getInt(_languageKey) ?? 0;
    _language = Language.values[languageIndex];
    notifyListeners();
  }

  Future<void> _saveLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_languageKey, _language.index);
  }
}

class LanguageContext extends InheritedNotifier<LanguageProvider> {
  const LanguageContext({
    super.key,
    required LanguageProvider languageProvider,
    required super.child,
  }) : super(notifier: languageProvider);

  static LanguageProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LanguageContext>()
        ?.notifier;
  }
}
