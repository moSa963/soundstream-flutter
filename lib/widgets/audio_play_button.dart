import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayButton extends StatelessWidget {
  const AudioPlayButton({super.key, this.audio, this.size = 50});
  final double size;
  final AudioPlayer? audio;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audio?.playerStateStream,
      builder: (context, snapshot) => IconButton.outlined(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(3))),
          onPressed: onPressed,
          icon: Icon(
            snapshot.data?.playing ?? false ? Icons.pause : Icons.play_arrow,
            size: size,
          ),
          padding: const EdgeInsets.all(0)),
    );
  }

  void onPressed() {
    if (audio?.playing != null) {
      audio?.playing ?? false ? audio?.pause() : audio?.play();
    }
  }
}
