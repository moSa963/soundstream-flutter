import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/widgets/page_banner.dart';

class ShowPlaylistBanner extends StatelessWidget {
  const ShowPlaylistBanner({super.key, required this.playlist});
  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return PageBanner(
      title: playlist.title,
      subtitle: playlist.description,
      image: Image.network( playlist.imgSrc, fit: BoxFit.contain, ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.update)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
      ],
    );
  }
}
