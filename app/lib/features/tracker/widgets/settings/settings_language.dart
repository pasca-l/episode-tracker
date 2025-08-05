// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/shared/providers/language_provider.dart';

class SettingsLanguage extends StatelessWidget {
  const SettingsLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = LanguageContext.of(context);
    Language? selectedLanguage =
        languageProvider?.language ?? Language.japanese;

    return Column(
      spacing: 10,
      children: [
        Row(
          spacing: 10,
          children: [
            Icon(
              Icons.language,
              size: 20,
            ),
            Text("Language Settings"),
          ],
        ),
        Divider(
          height: 0,
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              spacing: 10,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                ),
                Expanded(
                  child: Text(
                    'language setting affects title display in Checklist view',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            RadioListTile<Language>(
              dense: true,
              value: Language.japanese,
              title: Text('Japanese'),
              groupValue: selectedLanguage,
              onChanged: (value) {
                if (value != null) {
                  languageProvider?.setLanguage(value);
                }
              },
            ),
            RadioListTile<Language>(
              dense: true,
              value: Language.english,
              title: Text('English'),
              groupValue: selectedLanguage,
              onChanged: (value) {
                if (value != null) {
                  languageProvider?.setLanguage(value);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
