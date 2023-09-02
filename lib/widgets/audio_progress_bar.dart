import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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
        stream: audio?.onDurationChanged,
        builder: (context, durationSnapshot) {
          return StreamBuilder<Duration?>(
              stream: audio?.onPositionChanged,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    slider(snapshot,
                        (durationSnapshot.data?.inSeconds ?? 0) + 0.0),
                    if (!noLabels)
                      labels(snapshot, durationSnapshot.data ?? Duration.zero),
                  ],
                );
              });
        });
  }

  Widget slider(AsyncSnapshot<Duration?> snapshot, double max) {
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
          value: snapshot.data?.inSeconds.toDouble() ?? 0,
          onChanged: (v) {
            if (noSeek) return;
            audio?.seek(Duration(seconds: v.toInt()));
          },
        ));
  }

  Widget labels(AsyncSnapshot<Duration?> snapshot, Duration duration) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(DurationFormat.toHms(snapshot.data)),
          Text(DurationFormat.toHms(duration)), 
        ],
      ),
    );
  }
}
