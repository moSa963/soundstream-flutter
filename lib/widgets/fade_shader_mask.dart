import 'package:flutter/material.dart';

class FadeShaderMask extends StatelessWidget {
  const FadeShaderMask(
      {super.key,
      this.child,
      this.disabled = false,
      this.begin = Alignment.topCenter,
      this.end = Alignment.bottomCenter,
      this.rect});

  final Widget? child;
  final bool disabled;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final Rect Function(Rect rect)? rect;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (r) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              disabled ? Colors.black : Colors.transparent
            ],
          ).createShader(rect?.call(r) ?? r);
        },
        blendMode: BlendMode.dstIn,
        child: child);
  }
}
