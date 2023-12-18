import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/services/track_service.dart';
import 'package:soundstream_flutter/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:soundstream_flutter/widgets/bottom_sheet/track_options_sheet/remove_track_button.dart';
import 'package:soundstream_flutter/widgets/dialog/playlists_picker_dialog.dart';

class TrackOptionsSheet extends StatelessWidget {
  const TrackOptionsSheet(
      {super.key, required this.track, this.playlist, this.onTrackRemoved});
  final Track track;
  final Playlist? playlist;
  final _service = const TrackService();
  final void Function(Track track)? onTrackRemoved;

  @override
  Widget build(BuildContext context) {
    return BottomSheetCard(
      children: [
        TextButton(
            onPressed: () => _handleAddToPlaylist(context),
            child: const Text("Add to playlist")),
        if (onTrackRemoved != null &&
            (playlist == null ||
                context.watch<AuthProvider>().ownedPlaylist(playlist!)))
          RemoveTrackButton(
              service: _service,
              track: track,
              playlist: playlist,
              onRemoved: onTrackRemoved)
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
}
