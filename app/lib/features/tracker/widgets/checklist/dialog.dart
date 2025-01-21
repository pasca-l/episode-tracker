// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';

Future<void> showChecklistDialog(
  BuildContext context,
  Tracker tracker,
  Record record,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return ChecklistDialog(tracker: tracker, record: record);
    },
  );
}

class ChecklistDialog extends StatefulWidget {
  const ChecklistDialog({
    super.key,
    required this.tracker,
    required this.record,
  });

  final Tracker tracker;
  final Record record;

  @override
  State<ChecklistDialog> createState() => _ChecklistDialogState();
}

class _ChecklistDialogState extends State<ChecklistDialog> {
  late Timer _timer;
  bool _deleteEnabled = false;

  @override
  void initState() {
    super.initState();

    // set timer to enable the button after some seconds
    _timer = Timer(Duration(seconds: 5), () {
      setState(() {
        _deleteEnabled = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Delete record?"),
              IconButton(
                tooltip: "close modal",
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          Divider(),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Do you want to delete record for:"),
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.center,
              child: Text("'${widget.record.title}'"),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("cancel"),
        ),
        IconButton(
          tooltip: "delete this record",
          onPressed:
              _deleteEnabled
                  ? () {
                    TrackerRepository.deleteRecord(
                      widget.tracker,
                      widget.record,
                    );
                    Navigator.of(context).pop();
                  }
                  : null,
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
