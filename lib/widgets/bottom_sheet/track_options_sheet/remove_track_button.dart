import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/services/track_service.dart';
import 'package:soundstream_flutter/widgets/dialog/confirmation_dialog.dart';

class RemoveTrackButton extends StatelessWidget {
  const RemoveTrackButton(
      {super.key, required this.service, required this.track, required this.playlist});
  final TrackService service;
  final Track track;
  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () =>  _handleClick(context, playlist.album!),
        child: Text(
          "Remove from this ${playlist.album ?? false ? 'album' : 'playlist'}",
          style: const TextStyle(color: Colors.red),
        ));
  }

  void _handleClick(BuildContext context, bool fromAlbum) {
    Navigator.push(
        context,
        DialogRoute(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: fromAlbum
                ? "Do you want to remove this track completely from this album?"
                : "Do you want to remove this track?",
            subtitle: fromAlbum
                ? "You will not be able to restore this track after it has been removed"
                : "",
            onConfirmed: () {
              if (fromAlbum) {
                service.destroy(track);
              } else {
                service.removeFromPlaylist(playlist, track);
              }
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ));
  }
}
