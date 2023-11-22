import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class LyricsLine extends StatelessWidget {
  const LyricsLine(
      {super.key, required this.line, this.onTap, this.selected = false});
  final String line;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleGestureDetector(
      onTap: onTap,
        child: Text(
      line,
      style: TextStyle(
          color: !selected ? Theme.of(context).primaryColor : null,
          fontWeight: FontWeight.bold),
      textScaler: const TextScaler.linear(1.3),
    ));
  }
}
