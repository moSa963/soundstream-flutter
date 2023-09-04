

import 'package:flutter/material.dart';

class DialogLayout extends StatelessWidget {
  const DialogLayout({super.key, this.children = const []});
 final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: children
          ),
        ),
      ),
    );
  }
}