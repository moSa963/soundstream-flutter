import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/pages/show_playlist_page/show_playlist_banner.dart';
import 'package:soundstream_flutter/widgets/track_item.dart';

class ShowPlaylistPage extends StatefulWidget {
  const ShowPlaylistPage({super.key, required this.playlist});

  final Playlist playlist;

  @override
  State<ShowPlaylistPage> createState() => _ShowPlaylistPageState();
}

class _ShowPlaylistPageState extends State<ShowPlaylistPage> {
  final List<Track> tracks = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ShowPlaylistBanner(playlist: widget.playlist),
          TrackItem(track: Track(title: "TITLE")),
        ],
      ),
    );
  }
}
