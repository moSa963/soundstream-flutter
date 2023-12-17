import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_queue_provider.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/tracks_queue.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleGestureDetector(
        onTap: () => _handleTap(context),
        child: Icon(_getIcon(context), size: 25));
  }

  IconData _getIcon(BuildContext context) {
    final queue = context.watch<AudioQueueProvider>().queue;

    switch (queue.seekType) {
      case SeekType.linear:
        return Icons.shuffle;
      default:
        return Icons.shuffle_on;
    }
  }

  void _handleTap(BuildContext context) {
    final queue = context.read<AudioQueueProvider>().queue;
    switch (queue.seekType) {
      case SeekType.linear:
        queue.seekType = SeekType.random;
        break;
      default:
        queue.seekType = SeekType.linear;
        break;
    }
  }
}
