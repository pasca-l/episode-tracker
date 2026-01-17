// Flutter imports:
import 'package:flutter/material.dart';

class SharedSearchbar extends StatelessWidget {
  const SharedSearchbar({
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
        textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
        )),
        hintText: 'Search by title, pronunciation, or english title...',
        hintStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
        )),
        leading: Icon(Icons.search),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16.0),
        ),
        controller: controller,
      ),
    );
  }
}
