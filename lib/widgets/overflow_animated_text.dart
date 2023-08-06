import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/fade_shader_mask.dart';

class OverflowAnimatedText extends StatefulWidget {
  const OverflowAnimatedText(
    this.data, {
    super.key,
    this.speed = 20,
    this.delay = 5,
    this.style,
    this.textScaleFactor,
  });

  final String data;
  final int speed;
  final int delay;
  final double? textScaleFactor;
  final TextStyle? style;

  @override
  State<OverflowAnimatedText> createState() => _OverflowAnimatedTextState();
}

class _OverflowAnimatedTextState extends State<OverflowAnimatedText>
    with SingleTickerProviderStateMixin {
  final GlobalKey _flexKey = GlobalKey();
  final GlobalKey _textKey = GlobalKey();
  bool _disabled = true;

  late AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation = AnimationController.unbounded(vsync: this);

    _animation.addStatusListener((status) async {
      if (status != AnimationStatus.completed) return;

      if (_animation.value != 0) {
        _animation.duration = const Duration(seconds: 1);
        _animation.animateTo(0);
        return;
      }

      await Future.delayed(Duration(seconds: widget.delay));
      _animation.duration = duration;
      _animation.animateTo(_upperBound());
    });

    WidgetsBinding.instance.addPostFrameCallback(initAnimation);
  }

  void initAnimation(Duration time) {
    if (overflow <= 0) {
      _animation.value = 0;
      _animation.stop();
      return;
    }

    if (_disabled) {
      setState(() {
        _disabled = false;
      });
    }

    _animation.value = 0;
    _animation.duration = duration;
    _animation.animateTo(_upperBound());
  }

  @override
  void didUpdateWidget(covariant OverflowAnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disabled = true;

    if (oldWidget.data != widget.data) {
      WidgetsBinding.instance.addPostFrameCallback(initAnimation);
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(),
        clipBehavior: Clip.hardEdge,
        child: FadeShaderMask(
          begin: Alignment.bottomCenter,
          end: Alignment.bottomRight,
          disabled: _disabled,
          rect: (rect) =>
              Rect.fromLTRB(rect.width * 0.5, 0, rect.width, rect.height),
          child: Row(
            key: _flexKey,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(-_animation.value, 0),
                    child: child,
                  );
                },
                child: Text(widget.data,
                    key: _textKey,
                    style: widget.style,
                    textScaleFactor: widget.textScaleFactor),
              )
            ],
          ),
        ));
  }

  double get overflow {
    double textWidth = _textKey.currentContext?.size?.width ?? 0;
    double flexWidth = _flexKey.currentContext?.size?.width ?? 0;

    return textWidth - flexWidth;
  }

  Duration get duration => Duration(seconds: _upperBound() ~/ widget.speed);

  double _upperBound() {
    return overflow + (_flexKey.currentContext?.size?.width ?? 0) ~/ 2;
  }
}
