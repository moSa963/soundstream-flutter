import 'package:flutter/material.dart';

class MovableBox extends StatefulWidget {
  const MovableBox({super.key, required this.child, this.onPanEnd});
  final Widget child;
  final void Function(DragEndDetails)? onPanEnd;

  @override
  State<MovableBox> createState() => _MovableBoxState();
}

class _MovableBoxState extends State<MovableBox> with TickerProviderStateMixin {
  late final AnimationController _controller;
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: _offset = (_offset * _controller.value),
            child: child,
          );
        },
        child: GestureDetector(
            onPanUpdate: _handlePanUpdate,
            onPanEnd: _handlePanEnd,
            onPanStart: _handlePanStart,
            child: widget.child));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePanStart(DragStartDetails event) {
    _stopAnimation();
  }

  void _handlePanUpdate(DragUpdateDetails event) {
    setState(() {
      _offset += event.delta;
    });
  }

  void _handlePanEnd(DragEndDetails event) {
    _startAnimation();
    widget.onPanEnd?.call(event);
  }

  void _startAnimation() {
    _controller.value = 1;
    _controller.animateTo(0, duration: const Duration(milliseconds: 300));
  }

  void _stopAnimation() {
    _controller.stop();
    _controller.value = 1;
  }
}
