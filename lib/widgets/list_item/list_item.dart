import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class ListItem extends StatelessWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const ListItem({
    super.key,
    this.title = "",
    this.leading,
    this.subtitle = "",
    this.actions,
    this.onTap,
    this.titleStyle,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleGestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              height: 50,
              child: leading,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: titleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _subtitle(),
                ],
              ),
            ),
            Wrap(
              children: actions ?? [],
            )
          ],
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
