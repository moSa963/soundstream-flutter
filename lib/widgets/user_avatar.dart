import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.maxWidth, required this.user});
  final double? maxWidth;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return ScaleGestureDetector(
        child: Container(
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      padding: const EdgeInsets.all(5),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: AspectRatio(aspectRatio: 1, child: getImage()),
      ),
    ));
  }

  Widget getImage() {
    if (user?.imgUri != null) {
      return Image.network(
        user?.imgUri.toString() ?? "",
        fit: BoxFit.cover,
      );
    }

    return Container(
      color: Colors.blue,
    );
  }
}
