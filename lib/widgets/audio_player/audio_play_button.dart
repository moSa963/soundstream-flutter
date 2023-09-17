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
          context.watch<AudioQueueProvider>().state.playing
              ? Icons.pause
              : Icons.play_arrow,
          size: size,
        ),
        padding: const EdgeInsets.all(0));
  }

  void onPressed(BuildContext context) {
    final prov = context.read<AudioQueueProvider>();
    prov.state.playing ? prov.player.pause() : prov.player.play();
  }
}
