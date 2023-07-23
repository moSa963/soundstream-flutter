import 'dart:async';

import 'package:flutter/material.dart';

class TimedTextField extends StatefulWidget {
  const TimedTextField(
      {super.key,
      this.hintText,
      this.duration = const Duration(seconds: 1),
      this.onChange});
  final String? hintText;
  final Duration duration;
  final void Function(String value)? onChange;

  @override
  State<TimedTextField> createState() => _TimedTextFieldState();
}

class _TimedTextFieldState extends State<TimedTextField> {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText
      ),
      onChanged: onChanged,
    );
  }

  void onChanged(String value) {
    _timer?.cancel();

    _timer = Timer(widget.duration, () => widget.onChange?.call(value));
  }
}
