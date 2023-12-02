import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/pages/player_page/player_card.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/lyrics_viewer/lyrics_viewer.dart';
import 'package:soundstream_flutter/widgets/tracks_list.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: const PlayerCard(),
          ),
          LyricsViewer(
              track: context.watch<AudioQueueProvider>().track,
              position:
                  context.watch<AudioQueueProvider>().position ?? Duration.zero,
              setPosition: (int pos) => context
                  .read<AudioQueueProvider>()
                  .seek(Duration(milliseconds: pos))),
          TracksList(
            tracks: context.watch<AudioQueueProvider>().queue,
            updateTrack: (track) => _updateTrack(context, track),
            onTrackDeleted: (v) => _handleTrackDeleted(context, v),
            onTap: (track) => _playTrack(context, track),
          )
        ],
      ),
    );
  }

  void _playTrack(BuildContext context, Track track) {
    context.read<AudioQueueProvider>().seekTrack(track);
  }

  void _updateTrack(BuildContext context, Track track) {
    context.read<AudioQueueProvider>().updateTrack(track);
  }

  void _handleTrackDeleted(BuildContext context, Track track) {
    context.read<AudioQueueProvider>().remove(track);
  }
}
