import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/widgets/list_item.dart';

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;

  const PlaylistItem({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ListItem(
      leading: Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          fit: BoxFit.contain,
        ),
        title: playlist.title,
        subtitle: "${playlist.album ? "Album" : "Playlist"} . ${playlist.user?.username ?? ""}",
    );
  }
}
