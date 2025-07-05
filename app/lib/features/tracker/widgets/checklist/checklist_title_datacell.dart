// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/features/tracker/models/tracker.dart';
import 'package:app/features/tracker/repositories/tracker.dart';

class ChecklistTitleDataCell extends StatefulWidget {
  const ChecklistTitleDataCell({
    super.key,
    required this.tracker,
    required this.record,
  });

  final Tracker tracker;
  final Record record;

  @override
  State<ChecklistTitleDataCell> createState() => _ChecklistTitleDataCellState();
}

class _ChecklistTitleDataCellState extends State<ChecklistTitleDataCell> {
  late FocusNode _focus;
  late final TextEditingController _controller;
  bool _updateEnabled = false;

  void _onFocusChange() {
    if (!_focus.hasFocus && _updateEnabled) {
      TrackerRepository.updateRecord(
        widget.tracker,
        widget.record,
        title: _controller.text,
      );
      setState(() {
        _updateEnabled = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // update the textfield value when the unfocused
    _focus = FocusNode();
    _focus.addListener(_onFocusChange);

    // initialize the text shown for the textfield
    _controller = TextEditingController(text: widget.record.title);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 180, maxWidth: 180),
      child: TextFormField(
        controller: _controller,
        focusNode: _focus,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: "enter title",
          border: InputBorder.none,
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
    );
  }
}
