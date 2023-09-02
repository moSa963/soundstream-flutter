import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/button/audio_play_button.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class PlayerControlBar extends StatelessWidget {
  const PlayerControlBar({super.key, this.audio});
  final AudioPlayer? audio;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const ScaleGestureDetector(child: Icon(Icons.shuffle, size: 25)),
        Row(
          children: [
            ScaleGestureDetector(
                onDoubleTap: () => _backward(context),
                onTap: () => _onBackwardTap(context),
                child: const Icon(Icons.keyboard_double_arrow_left, size: 35)),
            const SizedBox(
              width: 10,
            ),
            AudioPlayButton(audio: audio),
            const SizedBox(
              width: 10,
            ),
            ScaleGestureDetector(
                onTap: () => _forward(context),
                child: const Icon(Icons.keyboard_double_arrow_right, size: 35)),
          ],
        ),
        const ScaleGestureDetector(child: Icon(Icons.repeat_on, size: 25)),
      ],
    );
  }

  void _backward(BuildContext context) async {
    await context.read<AudioQueueProvider>().backward();
  }

  void _onBackwardTap(BuildContext context) async {
    final pos = (await audio?.getCurrentPosition())?.inSeconds ?? 0;

    if (context.mounted) {
      pos > 10 ? _reset(context) : _backward(context);
    }
  }

  void _reset(BuildContext context) {
    context.read<AudioQueueProvider>().reset();
  }

  void _forward(BuildContext context) async {
    await context.read<AudioQueueProvider>().forward();
  }
}
