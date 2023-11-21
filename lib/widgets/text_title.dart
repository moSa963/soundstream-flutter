import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        data,
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold),
        textScaler: const TextScaler.linear(1.8),
      ),
    );
  }
}
