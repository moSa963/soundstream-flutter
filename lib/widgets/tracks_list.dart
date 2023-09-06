import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/list_item/track_item.dart';

class TracksList extends StatelessWidget {
  const TracksList(
      {super.key, required this.tracks, this.updateTrack, this.onTap, this.playlist});
  final List<Track> tracks;
  final Playlist? playlist;
  final void Function(Track)? updateTrack;
  final void Function(Track)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (Track track in tracks)
          TrackItem(
            key: Key(track.id.toString()),
            track: track,
            onTap: () =>
                onTap == null ? _handleTap(context, track) : onTap!.call(track),
            updateTrack: updateTrack,
            onLongPress: () => _handleLongPress(context, track),
          ),
      ],
    );
  }

  void _handleTap(BuildContext context, Track track) {
    context
        .read<AudioQueueProvider>()
        .setList(tracks, index: tracks.indexOf(track));
  }

  void _handleLongPress(BuildContext context, Track track) {

  }
}
