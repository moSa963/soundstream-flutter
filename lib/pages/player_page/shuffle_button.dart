import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_provider_options.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_queue_provider.dart';
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
    final options = context.watch<AudioQueueProvider>().options;

    switch (options.seekType) {
      case SeekType.linear:
        return Icons.shuffle;
      default:
        return Icons.shuffle_on;
    }
  }

  void _handleTap(BuildContext context) {
    final options = context.read<AudioQueueProvider>().options;
    switch (options.seekType) {
      case SeekType.linear:
        options.seekType = SeekType.random;
        break;
      default:
        options.seekType = SeekType.linear;
        break;
    }
  }
}
