import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayButton extends StatelessWidget {
  const AudioPlayButton({super.key, this.audio, this.size = 50});
  final double size;
  final AudioPlayer? audio;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audio?.onPlayerStateChanged,
      builder: (context, snapshot) => IconButton.outlined(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(3))),
          onPressed: onPressed,
          icon: Icon(
            snapshot.data == PlayerState.playing
                ? Icons.pause
                : Icons.play_arrow,
            size: size,
          ),
          padding: const EdgeInsets.all(0)),
    );
  }

  void onPressed() {
    audio?.state == PlayerState.playing ? audio?.pause() : audio?.resume();
  }
}
