import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/fade_shader_mask.dart';

class OverflowAnimatedText extends StatefulWidget {
  const OverflowAnimatedText(
    this.data, {
    super.key,
    this.speed = 40,
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

class _OverflowAnimatedTextState extends State<OverflowAnimatedText> {
  final _scrollController = ScrollController();
  bool _overflown = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _start();
      setState(() {
        _overflown = isOverflown();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(),
        clipBehavior: Clip.hardEdge,
        child: FadeShaderMask(
            begin: Alignment.bottomCenter,
            end: Alignment.bottomRight,
            disabled: !_overflown,
            rect: (rect) =>
                Rect.fromLTRB(rect.width * 0.5, 0, rect.width, rect.height),
            child: SingleChildScrollView(
                controller: _scrollController,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data,
                      textScaler: widget.textScaleFactor == null ? null : TextScaler.linear(widget.textScaleFactor!),
                      style: widget.style,
                    ),
                    const SizedBox(
                      width: 100,
                    )
                  ],
                ))));
  }

  void _start() async {
    if (!isOverflown()) return;

    await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(
            seconds:
                _scrollController.position.maxScrollExtent ~/ widget.speed),
        curve: Curves.linear);

    if (!_scrollController.hasClients) return;
    await _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);

    if (!_scrollController.hasClients) return;
    await Future.delayed(Duration(seconds: widget.delay));

    _start();
  }

  bool isOverflown() {
    return _scrollController.hasClients &&
        (_scrollController.position.maxScrollExtent -
                (100 * _scrollController.position.devicePixelRatio)) >
            0;
  }
}
