// Flutter imports:
import 'package:flutter/material.dart';

class SettingsImports extends StatelessWidget {
  const SettingsImports({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          spacing: 10,
          children: [
            Icon(
              Icons.file_present,
              size: 20,
            ),
            Text("Import and export data"),
          ],
        ),
        Divider(
          height: 0,
        ),
        ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              dense: true,
              leading: Icon(Icons.file_upload),
              title: Text("Import from file"),
              onTap: () {},
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.file_download),
              title: Text("Export to file"),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
