import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/pages/player_page/player_page.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/list_item/track_item.dart';

class TracksList extends StatelessWidget {
  const TracksList({super.key, required this.tracks, this.updateTrack});
  final List<Track> tracks;
  final void Function(Track)? updateTrack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (Track track in tracks)
          TrackItem(
            key: Key(track.id.toString()),
            track: track,
            onTap: () => handleTap(context, track),
            updateTrack: updateTrack,
          ),
      ],
    );
  }

  void handleTap(BuildContext context, Track track) {
    context
        .read<AudioQueueProvider>()
        .setList(tracks, index: tracks.indexOf(track));

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const PlayerPage();
      },
    ));
  }

}
