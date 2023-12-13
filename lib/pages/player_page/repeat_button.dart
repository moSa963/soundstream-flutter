import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_provider_options.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';

class RepeatButton extends StatelessWidget {
  const RepeatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleGestureDetector(
        onTap: () => _handleTap(context),
        child: Icon(_getIcon(context), size: 25));
  }

  IconData _getIcon(BuildContext context) {
    final options = context.watch<AudioQueueProvider>().options;

    switch (options.repeatType) {
      case RepeatType.noRepeat:
        return Icons.repeat;
      case RepeatType.repeatOne:
        return Icons.repeat_one_on;
      default:
        return Icons.repeat_on;
    }
  }

  void _handleTap(BuildContext context) {
    final options = context.read<AudioQueueProvider>().options;
    switch (options.repeatType) {
      case RepeatType.noRepeat:
        options.repeatType = RepeatType.repeatOne;
        break;
      case RepeatType.repeatOne:
        options.repeatType = RepeatType.repeat;
        break;
      default:
        options.repeatType = RepeatType.noRepeat;
        break;
    }
  }
}
