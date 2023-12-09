import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';
import 'package:soundstream_flutter/widgets/analyzed_image.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';
import 'package:soundstream_flutter/widgets/button/upload_button.dart';
import 'package:soundstream_flutter/widgets/page_banner.dart';
import 'package:soundstream_flutter/widgets/bottom_sheet/update_playlist_sheet.dart';
import 'package:soundstream_flutter/widgets/user_chip.dart';

class ShowPlaylistBanner extends StatefulWidget {
  const ShowPlaylistBanner(
      {super.key, required this.playlist, this.onTrackAdded});
  final Playlist playlist;
  final void Function(Track track)? onTrackAdded;

  @override
  State<ShowPlaylistBanner> createState() => _ShowPlaylistBannerState();
}

class _ShowPlaylistBannerState extends State<ShowPlaylistBanner> {
  Color? _color;

  @override
  Widget build(BuildContext context) {
    final playlist = context
        .watch<PlaylistsProvider>()
        .playlists
        .where(
          (element) => element.id == widget.playlist.id,
        )
        .first;

    return PageBanner(
      title: playlist.title ?? "",
      subtitle: playlist.description ?? "",
      color: _color,
      image: ScaleGestureDetector(
        onTap: () => _onUpdateImage(playlist),
        child: Hero(
          tag: "playlist ${playlist.id}",
          child: AnalyzedImage(
            src: playlist.imgUri.toString(),
            fit: BoxFit.cover,
            onColor: (value) => setState(() => _color = value),
          ),
        ),
      ),
      leading: [
        Text(
          playlist.album ?? false ? "Album" : "Playlist",
          style: const TextStyle(color: Colors.grey),
        ),
        const Spacer(),
        IconButton(
            onPressed: () => _onUpdate(context, playlist),
            icon: const Icon(Icons.edit)),
      ],
      actions: _actions(context, playlist),
    );
  }

  List<Widget> _actions(BuildContext context, Playlist playlist) {
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
          onDone: widget.onTrackAdded,
        )
    ];
  }

  void _onUpdate(BuildContext context, Playlist playlist) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return UpdatePlaylistSheet(playlist: playlist);
        });
  }

  void _onUpdateImage(Playlist playlist) async {
    FilePickerResult? res =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (res == null) return;

    if (context.mounted) {
      context.read<PlaylistsProvider>().updateImage(playlist, res.files[0]);
    }
  }
}
