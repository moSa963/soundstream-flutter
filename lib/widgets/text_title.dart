import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold),
      textScaleFactor: 1.8,
    );
  }
}
