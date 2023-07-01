import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/audio_play_button.dart';
import 'package:soundstream_flutter/widgets/scale_gesture_detector.dart';

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

  void _backward(BuildContext context) {
    context.read<AudioQueueProvider>().backward();
  }

  void _onBackwardTap(BuildContext context) {
    if ((audio?.position.inSeconds ?? 0) < 10) return _backward(context);
    _reset(context);
  }

  void _reset(BuildContext context) {
    context.read<AudioQueueProvider>().reset();
  }

  void _forward(BuildContext context) {
    context.read<AudioQueueProvider>().forward();
  }
}
