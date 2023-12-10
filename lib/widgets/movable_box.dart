import 'package:flutter/material.dart';

class MovableBox extends StatefulWidget {
  const MovableBox({super.key, required this.child});
  final Widget child;

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

  void _handlePanUpdate(DragUpdateDetails data) {
    setState(() {
      _offset += data.delta;
    });
  }

  void _handlePanEnd(DragEndDetails data) {
    setState(() {
      _offset = Offset.zero;
    });
  }
}
