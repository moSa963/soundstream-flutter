import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_queue_provider.dart';
import 'package:soundstream_flutter/utils/duration_format.dart';

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar(
      {super.key,
      this.noLabels = false,
      this.noSeek = false,
      this.trackHeight = 5});
  final bool noLabels;
  final bool noSeek;
  final double trackHeight;

  @override
  Widget build(BuildContext context) {
    final pro = context.watch<AudioQueueProvider>();

    return Column(
      children: [
        slider(pro.player, pro.position?.inSeconds.toDouble() ?? 0.0,
            pro.duration?.inSeconds.toDouble() ?? double.infinity),
        if (!noLabels)
          labels(pro.position ?? Duration.zero, pro.duration ?? Duration.zero),
      ],
    );
  }

  Widget slider(AudioPlayer audio, double value, double max) {
    return SliderTheme(
        data: SliderThemeData(
          thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: noSeek ? 0 : 5,
              disabledThumbRadius: noSeek ? 0 : 5),
          trackHeight: trackHeight,
          overlayShape: SliderComponentShape.noOverlay,
          trackShape: const RectangularSliderTrackShape(),
        ),
        child: Slider(
          min: 0,
          max: max,
          value: value,
          onChanged: (v) {
            if (noSeek) return;
            audio.seek(Duration(seconds: v.toInt()));
          },
        ));
  }

  Widget labels(Duration position, Duration duration) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(DurationFormat.toHms(position)),
          Text(DurationFormat.toHms(duration)),
        ],
      ),
    );
  }
}
