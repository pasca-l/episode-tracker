// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/widgets/checklist/checklist_list.dart';
import 'package:app/features/tracker/widgets/shared/filtered_records_builder.dart';
import 'package:app/features/tracker/widgets/shared/searchbar.dart';
import 'package:app/shared/providers/language_provider.dart';

class ChecklistView extends ConsumerWidget {
  const ChecklistView({
    super.key,
    required this.tracker,
    required this.records,
    required this.queryController,
  });

  final Tracker tracker;
  final List<Record> records;
  final TextEditingController queryController;

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
        child: FilteredRecordsBuilder(
          records: records,
          queryController: queryController,
          builder: (context, filteredRecords) {
            return Column(
              spacing: 20,
              children: [
                SharedSearchbar(controller: queryController),
                Expanded(
                  child: ChecklistList(
                    tracker: tracker,
                    records: filteredRecords,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
