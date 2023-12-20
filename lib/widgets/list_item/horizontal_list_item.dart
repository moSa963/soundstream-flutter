import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class HorizontalListItem extends StatelessWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const HorizontalListItem({
    super.key,
    this.title = "",
    this.leading,
    this.subtitle = "",
    this.actions,
    this.titleStyle,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: .8,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: ScaleGestureDetector(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Column(
            children: [
              if (leading != null) Expanded(child: leading!),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _subtitle(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subtitle() {
    return Text(subtitle,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.grey[500],
        ));
  }
}
