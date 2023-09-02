import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider.dart';

class AudioPlayButton extends StatelessWidget {
  const AudioPlayButton({super.key, this.size = 50});
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onPressed(context),
        icon: Icon(
          context.watch<AudioQueueProvider>().state == PlayerState.playing
              ? Icons.pause
              : Icons.play_arrow,
          size: size,
        ),
        padding: const EdgeInsets.all(0));
  }

  void onPressed(BuildContext context) {
    final player = context.read<AudioQueueProvider>().player;
    player.state == PlayerState.playing ? player.pause() : player.resume();
  }
}
