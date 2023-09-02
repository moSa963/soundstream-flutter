import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/pages/player_page/player_control_bar.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/audio_player/audio_progress_bar.dart';
import 'package:soundstream_flutter/widgets/overflow_animated_text.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AudioQueueProvider>();

    return Column(children: [
      _img(context, provider.track),
      const SizedBox(height: 15),
      _title(provider.track),
      const SizedBox(height: 25),
      AudioProgressBar(audio: provider.player),
      const SizedBox(height: 15),
      PlayerControlBar(audio: provider.player),
      const SizedBox(height: 25),
    ]);
  }

  Widget _img(BuildContext context, Track? track) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height / 2),
      child: AspectRatio(
        aspectRatio: 1,
        child: track != null
            ? Image.network(track.imgUri.toString())
            : const Placeholder(),
      ),
    );
  }

  Widget _title(Track? track) {
    return Column(
      children: [
        OverflowAnimatedText(
          track?.title ?? "",
          textScaleFactor: 2,
        ),
        Text(track?.user?.username ?? "",
            style: const TextStyle(color: Colors.grey),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
