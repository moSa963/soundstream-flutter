import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/pages/player_page/repeat_button.dart';
import 'package:soundstream_flutter/pages/player_page/shuffle_button.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/audio_player/audio_play_button.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class PlayerControlBar extends StatelessWidget {
  const PlayerControlBar({super.key, this.audio});
  final AudioPlayer? audio;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const ShuffleButton(),
        Row(
          children: [
            ScaleGestureDetector(
                onDoubleTap: () => _backward(context),
                onTap: () => _onBackwardTap(context),
                child: const Icon(Icons.keyboard_double_arrow_left, size: 35)),
            const SizedBox(
              width: 10,
            ),
            const AudioPlayButton(),
            const SizedBox(
              width: 10,
            ),
            ScaleGestureDetector(
                onTap: () => _forward(context),
                child: const Icon(Icons.keyboard_double_arrow_right, size: 35)),
          ],
        ),
        const RepeatButton(),
      ],
    );
  }

  void _backward(BuildContext context) async {
    await context.read<AudioQueueProvider>().queue.backward();
  }

  void _onBackwardTap(BuildContext context) async {
    final pos = audio?.position.inSeconds ?? 0;

    if (context.mounted) {
      pos > 10 ? _reset(context) : _backward(context);
    }
  }

  void _reset(BuildContext context) {
    context.read<AudioQueueProvider>().reset();
  }

  void _forward(BuildContext context) async {
    await context.read<AudioQueueProvider>().queue.forward();
  }
}
