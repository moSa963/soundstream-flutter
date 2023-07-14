import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleGestureDetector(
        child: Container(
      padding: const EdgeInsets.all(5),
      child: const CircleAvatar(),
    ));
  }
}
