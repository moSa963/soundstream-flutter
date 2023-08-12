import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/widgets/button/upload_button.dart';
import 'package:soundstream_flutter/widgets/page_banner.dart';
import 'package:soundstream_flutter/widgets/bottom_sheet/update_playlist_sheet.dart';
import 'package:soundstream_flutter/widgets/user_chip.dart';

class ShowPlaylistBanner extends StatelessWidget {
  const ShowPlaylistBanner(
      {super.key, required this.playlist, this.onTrackAdded});
  final Playlist playlist;
  final void Function(Track track)? onTrackAdded;

  @override
  Widget build(BuildContext context) {
    return PageBanner(
      title: playlist.title ?? "",
      subtitle: playlist.description ?? "",
      image: Hero(
        tag: "playlist ${playlist.id}",
        child: Image.network(
          playlist.imgUri.toString(),
          fit: BoxFit.cover,
        ),
      ),
      leading: [
        Text(
          playlist.album ?? false ? "Album" : "Playlist",
          style: const TextStyle(color: Colors.grey),
        ),
        const Spacer(),
        IconButton(
            onPressed: () => _onUpdate(context), icon: const Icon(Icons.edit)),
      ],
      actions: _actions(context),
    );
  }

  List<Widget> _actions(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserChip(
            user: playlist.user,
          ),
          const Text(" . "),
          Text(
              "${playlist.private ?? false ? 'Public' : 'Private'} ${playlist.tracksCount} track"),
        ],
      ),
      const Spacer(),
      if (playlist.album == true &&
          context.watch<AuthProvider>().ownedPlaylist(playlist))
        UploadButton(
          album: playlist,
          onDone: onTrackAdded,
        )
    ];
  }

  void _onUpdate(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return UpdatePlaylistSheet(playlist: playlist);
        });
  }
}
