// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';

class HistoryDrawer extends StatefulWidget {
  const HistoryDrawer({super.key, required this.tracker, required this.record});

  final Tracker tracker;
  final Record record;

  @override
  State<HistoryDrawer> createState() => _HistoryDrawerState();
}

class _HistoryDrawerState extends State<HistoryDrawer> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;
  bool _isChecked = false;
  late Timer _timer;
  bool _updateEnabled = false;
  bool _deleteEnabled = false;

  @override
  void initState() {
    super.initState();

    // initialize with read data
    _controllers = {
      "title": TextEditingController(text: widget.record.title),
      "title_pronunciation": TextEditingController(
        text: widget.record.titlePronunciation,
      ),
      "title_english": TextEditingController(text: widget.record.titleEnglish),
      "episode":
          TextEditingController(text: widget.record.episode.last.toString()),
      "aired_from": TextEditingController(
        text: widget.record.airedFrom.toString().substring(0, 10),
      ),
    };
    _isChecked = widget.record.watched;

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
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  TextFormField(
                    controller: _controllers["title"],
                    decoration: InputDecoration(labelText: "Title"),
                    onChanged: (_) {
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
                  TextFormField(
                    controller: _controllers["title_pronunciation"],
                    decoration: InputDecoration(
                      labelText: "Title pronunciation",
                    ),
                    onChanged: (_) {
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
                  TextFormField(
                    controller: _controllers["title_english"],
                    decoration: InputDecoration(labelText: "Title in English"),
                    onChanged: (_) {
                      setState(() {
                        _updateEnabled = true;
                      });
                    },
                  ),
                  TextFormField(
                    controller: _controllers["episode"],
                    decoration: InputDecoration(labelText: "Episode"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) {
                      setState(() {
                        _updateEnabled = true;
                      });
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter some number";
                      } else if (int.parse(val) > 10000) {
                        return "Number may be too large";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  TextFormField(
                    controller: _controllers["aired_from"],
                    decoration: InputDecoration(labelText: "Aired from"),
                    readOnly: true,
                    onTap: () async {
                      DateTime? selected = await showDatePicker(
                        context: context,
                        initialDate: widget.record.airedFrom,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selected != null) {
                        _controllers["aired_from"]!.text =
                            selected.toString().substring(0, 10);
                        setState(() {
                          _updateEnabled = true;
                        });
                      }
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Watched?"),
                    value: _isChecked,
                    onChanged: (_) {
                      setState(() {
                        _isChecked = !_isChecked;
                        _updateEnabled = true;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(20), child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _updateEnabled && _formKey.currentState!.validate()
                      ? () {
                          TrackerRepository.updateRecord(
                            widget.tracker,
                            widget.record,
                            title: _controllers["title"]!.text,
                            titlePronunciation:
                                _controllers["title_pronunciation"]!.text,
                            titleEnglish: _controllers["title_english"]!.text,
                            episode: List<int>.from(
                                [int.parse(_controllers["episode"]!.text)]),
                            airedFrom: DateTime.parse(
                              _controllers["aired_from"]!.text,
                            ),
                            watched: _isChecked,
                          );
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: Text("update"),
                ),
                IconButton(
                  tooltip: "delete this record",
                  onPressed: _deleteEnabled && !_updateEnabled
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
            ),
          ],
        ),
      ),
    );
  }
}
