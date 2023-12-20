import 'package:flutter/material.dart';

class AudioStateIcon extends StatefulWidget {
  const AudioStateIcon({super.key, this.active = false});
  final bool active;

  @override
  State<AudioStateIcon> createState() => _AudioStateIconState();
}

class _AudioStateIconState extends State<AudioStateIcon> {
  double _factor = 1;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _getLine(const Duration(milliseconds: 1300)),
          _getLine(const Duration(milliseconds: 800)),
          _getLine(const Duration(milliseconds: 1000)),
          _getLine(const Duration(milliseconds: 500)),
          _getLine(const Duration(milliseconds: 300)),
        ],
      ),
    );
  }

  Widget _getLine(Duration duration) {
    return Expanded(
        child: AnimatedFractionallySizedBox(
            duration: duration,
            heightFactor: _factor,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0.2),
              color: widget.active
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            )));
  }

  void _start() async {
    while (mounted) {
      setState(() {
        _factor = widget.active
            ? _factor == 0.2
                ? 0.8
                : 0.2
            : 0.2;
      });

      await Future.delayed(const Duration(milliseconds: 800));
    }
  }
}
