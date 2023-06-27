import 'package:flutter/material.dart';

class ScaleGestureDetector extends StatefulWidget {
  const ScaleGestureDetector(
      {super.key, required this.child, this.onTap, this.onLongPress});

  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  State<ScaleGestureDetector> createState() => _ScaleGestureDetectorState();
}

class _ScaleGestureDetectorState extends State<ScaleGestureDetector> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: (_) => setState(() {
        _down = true;
      }),
      onTapUp: (_) => setState(() {
        _down = false;
      }),
      onTapCancel: () => setState(() {
        _down = false;
      }),
      child: Transform.scale(
        scale: _down ? 0.98 : 1,
        child: Opacity(
          opacity: _down ? 0.8 : 1,
          child: widget.child,
        ),
      ),
    );
  }
}
