// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/checklist/checklist_list.dart';
import 'package:app/shared/providers/language_provider.dart';

class ChecklistView extends ConsumerWidget {
  const ChecklistView(
      {super.key, required this.tracker, required this.records});

  final Tracker tracker;
  final List<Record> records;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // wait for the language to be loaded
    final language = ref.watch(languageProvider);
    if (language == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40,
        ),
        child: ChecklistList(tracker: tracker, records: records),
      ),
    );
  }
}
