import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/scale_gesture_detector.dart';

class ListItem extends StatelessWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const ListItem({
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
    return ScaleGestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: ListTile(
        leading: leading,
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: _subtitle(),
        contentPadding: const EdgeInsets.all(0),
        trailing: Wrap(
          children: actions ?? [],
        ),
        horizontalTitleGap: 10,
      ),
    );
  }

  Widget _subtitle() {
    return Text(subtitle,
        style: TextStyle(
          color: Colors.grey[500],
        ));
  }
}
