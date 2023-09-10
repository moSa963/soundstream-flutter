import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/services/track_service.dart';
import 'package:soundstream_flutter/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:soundstream_flutter/widgets/dialog/confirmation_dialog.dart';
import 'package:soundstream_flutter/widgets/dialog/playlists_picker_dialog.dart';

class TrackOptionsSheet extends StatelessWidget {
  const TrackOptionsSheet({super.key, required this.track, this.playlist});
  final Track track;
  final Playlist? playlist;
  final _service = const TrackService();

  @override
  Widget build(BuildContext context) {
    return BottomSheetCard(
      children: [
        TextButton(
            onPressed: () => _handleAddToPlaylist(context),
            child: const Text("Add to playlist")),
        if (playlist != null &&
            context.watch<AuthProvider>().ownedPlaylist(playlist!))
          TextButton(
              onPressed: () =>
                  _handleRemoveFromPlaylist(context, playlist!.album!),
              child: Text(
                "Remove from this ${playlist!.album! ? 'album' : 'playlist'}",
                style: const TextStyle(color: Colors.red),
              )),
      ],
    );
  }

  void _handleAddToPlaylist(BuildContext context) {
    Navigator.push(
        context,
        DialogRoute(
          context: context,
          builder: (context) => PlaylistPickerDialog(
            filter: (authUser, playlist) =>
                authUser?.username == playlist.user?.username &&
                !(playlist.album ?? true),
            onPicked: (playlist) async {
              _service.addToPlaylist(playlist, track);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ));
  }

  void _handleRemoveFromPlaylist(BuildContext context, bool fromAlbum) {
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
                _service.destroy(track);
              } else {
                _service.removeFromPlaylist(playlist!, track);
              }
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ));
  }
}
