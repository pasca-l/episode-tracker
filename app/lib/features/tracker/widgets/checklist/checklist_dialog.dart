import 'dart:async';
import 'package:flutter/material.dart';

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
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  late Timer _timer;
  bool _updateEnabled = false;
  bool _deleteEnabled = false;

  @override
  void initState() {
    super.initState();

    // initialize the text shown for the textfield
    _controller = TextEditingController(text: widget.record.title);

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
    _controller.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Record Information", style: TextStyle(fontSize: 18)),
          IconButton(
            tooltip: "close modal",
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(labelText: "Title"),
          onChanged: (value) {
            setState(() {
              _updateEnabled = true;
            });
          },
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter some text";
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      actions: [
        TextButton(
          onPressed:
              _updateEnabled && _formKey.currentState!.validate()
                  ? () {
                    TrackerRepository.updateRecord(
                      widget.tracker,
                      widget.record,
                      title: _controller.text,
                    );
                    Navigator.of(context).pop();
                  }
                  : null,
          child: Text("update"),
        ),
        IconButton(
          tooltip: "delete this record",
          onPressed:
              _deleteEnabled && !_updateEnabled
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
