import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/pages/show_playlist_page/show_playlist_page.dart';
import 'package:soundstream_flutter/widgets/list_item/list_item.dart';

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;

  const PlaylistItem({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ListItem(
      onTap: () => _openShowPlaylistPage(context),
      leading: AspectRatio(aspectRatio: 1, child: Hero(tag: "${playlist.id}", child: Image.network(playlist.imgUri.toString(), fit: BoxFit.cover,))),
      title: playlist.title ?? "",
      subtitle:
          "${playlist.album ?? false ? "Album" : "Playlist"} . @${playlist.user?.username ?? ""}",
    );
  }

  void _openShowPlaylistPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ShowPlaylistPage(playlist: playlist,);
      },
    ));
  }
}
