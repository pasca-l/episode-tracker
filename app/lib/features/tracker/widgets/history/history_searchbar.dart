// Flutter imports:
import 'package:flutter/material.dart';

class HistorySearchbar extends StatelessWidget {
  const HistorySearchbar({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: SearchBar(
        hintText: 'Search by title, pronunciation, or english title...',
        leading: Icon(Icons.search),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16.0),
        ),
        controller: controller,
      ),
    );
  }
}
