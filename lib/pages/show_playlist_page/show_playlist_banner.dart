import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';
import 'package:soundstream_flutter/widgets/page_banner.dart';
import 'package:soundstream_flutter/widgets/bottom_sheet/update_playlist_sheet.dart';
import 'package:soundstream_flutter/widgets/user_avatar.dart';

class ShowPlaylistBanner extends StatelessWidget {
  const ShowPlaylistBanner({super.key, required this.playlist});
  final Playlist playlist;

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
      actions: [_action(context)],
    );
  }

  Widget _action(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleGestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserAvatar(user: playlist.user, maxWidth: 35),
              Text(
                "@${playlist.user?.username}",
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
        ),
        const Text(" . "),
        Text(
            "${playlist.private ?? false ? 'Public' : 'Private'} ${playlist.tracksCount} track"),
      ],
    );
  }

  void _onUpdate(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return UpdatePlaylistSheet(playlist: playlist);
        });
  }
}
