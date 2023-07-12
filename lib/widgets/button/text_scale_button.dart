import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class TextScaleButton extends StatelessWidget {
  const TextScaleButton(this.text, {super.key, this.onTap});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleGestureDetector(
      onTap: onTap,
      child: Text(text,
          style: TextStyle(color: Theme.of(context).colorScheme.primary)),
    );
  }
}
