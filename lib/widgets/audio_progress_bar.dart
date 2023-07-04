import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundstream_flutter/utils/duration_format.dart';

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar(
      {super.key,
      this.audio,
      this.noLabels = false,
      this.noSeek = false,
      this.trackHeight = 5});
  final AudioPlayer? audio;
  final bool noLabels;
  final bool noSeek;
  final double trackHeight;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
        stream: audio?.durationStream,
        builder: (context, snapshot) {
          return StreamBuilder<Duration?>(
              stream: audio?.positionStream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    slider(snapshot),
                    if (!noLabels) labels(snapshot),
                  ],
                );
              });
        });
  }

  Widget slider(AsyncSnapshot<Duration?> snapshot) {
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
          max: audio?.duration?.inSeconds.toDouble() ?? 0.0,
          value: snapshot.data?.inSeconds.toDouble() ?? 0,
          onChanged: (v) {
            if (noSeek) return;
            audio?.seek(Duration(seconds: v.toInt()));
          },
        ));
  }

  Widget labels(AsyncSnapshot<Duration?> snapshot) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(DurationFormat.toHms(snapshot.data)),
          Text(DurationFormat.toHms(audio?.duration)),
        ],
      ),
    );
  }
}
