import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class HorizontalListItem extends StatelessWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const HorizontalListItem({
    super.key,
    this.title = "",
    this.leading,
    this.subtitle = "",
    this.actions,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: .5,
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ScaleGestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Column(
              children: [
                SizedBox(
                  child: leading,
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    _subtitle(),
                  ],
                ),
                Wrap(
                  children: actions ?? [],
                )
              ],
            ),
          ),
        ));
  }

  Widget _subtitle() {
    return Text(subtitle,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.grey[500],
        ));
  }
}
