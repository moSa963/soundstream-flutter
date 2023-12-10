import 'package:flutter/material.dart';

class MovableBox extends StatefulWidget {
  const MovableBox({super.key, required this.child, this.onPanEnd});
  final Widget child;
  final void Function(DragEndDetails)? onPanEnd;

  @override
  State<MovableBox> createState() => _MovableBoxState();
}

class _MovableBoxState extends State<MovableBox> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: Transform.translate(
        offset: _offset,
        child: widget.child,
      ),
    );
  }

  void _handlePanUpdate(DragUpdateDetails event) {
    setState(() {
      _offset += event.delta;
    });
  }

  void _handlePanEnd(DragEndDetails event) {
    setState(() {
      _offset = Offset.zero;
    });

    widget.onPanEnd?.call(event);
  }
}
