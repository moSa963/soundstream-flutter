import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';
import 'package:soundstream_flutter/widgets/fade_shader_mask.dart';
import 'package:soundstream_flutter/widgets/text_title.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList(
      {super.key,
      this.height = 150,
      this.title = "",
      this.onTitleTap,
      this.padding = EdgeInsets.zero,
      this.children = const []});

  final double height;
  final String title;
  final void Function()? onTitleTap;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScaleGestureDetector(
            onTap: onTitleTap,
            child: TextTitle(title),
          ),
          FadeShaderMask(
            begin: Alignment.bottomCenter,
            end: Alignment.bottomRight,
            disabled: children.isEmpty,
            rect: (rect) =>
                Rect.fromLTRB(rect.width * 0.7, 0, rect.width, rect.height),
            child: SizedBox(
              height: height,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children:
                    children.isEmpty ? [const Text("No items")] : children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
