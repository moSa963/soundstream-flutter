import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/pages/player_page/player_control_bar.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/audio_progress_bar.dart';
import 'package:soundstream_flutter/widgets/overflow_animated_text.dart';
import 'package:soundstream_flutter/widgets/list_item/track_item.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AudioQueueProvider>();

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              img(context),
              const SizedBox(height: 15),
              title(provider.track),
              const SizedBox(height: 25),
              AudioProgressBar(audio: provider.audio),
              const SizedBox(height: 15),
              PlayerControlBar(audio: provider.audio),
              const SizedBox(height: 25),
            ]),
          ),
          for (var v in context.watch<AudioQueueProvider>().queue)
            TrackItem(
              key: Key(v.id.toString()),
              track: v,
              onTap: () => playTrack(context, v),
            )
        ],
      ),
    );
  }

  Widget img(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height / 2),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
      ),
    );
  }

  Widget title(Track? track) {
    return Column(
      children: [
        OverflowAnimatedText(track?.title ?? "", textScaleFactor: 2),
        Text(track?.user?.username ?? "@",
            style: const TextStyle(color: Colors.grey),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }

  void playTrack(BuildContext context, Track track) {
    context.read<AudioQueueProvider>().seekTrack(track);
  }
}
