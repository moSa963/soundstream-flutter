import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/widgets/scale_gesture_detector.dart';

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;

  const PlaylistItem({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ScaleGestureDetector(
      child: ListTile(
        leading: Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          fit: BoxFit.contain,
        ),
        title: Text(
          playlist.title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: _subtitle(),
        contentPadding: const EdgeInsets.all(0),
      ),
    );
  }

  Widget _subtitle() {
    return Text(
        "${playlist.album ? "Album" : "Playlist"} . ${playlist.user?.username ?? ""}",
        style: TextStyle(
          color: Colors.grey[500],
        ));
  }
}
