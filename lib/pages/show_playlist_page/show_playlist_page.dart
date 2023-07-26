import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/pages/show_playlist_page/show_playlist_banner.dart';
import 'package:soundstream_flutter/services/playlist_service.dart';
import 'package:soundstream_flutter/services/track_service.dart';
import 'package:soundstream_flutter/widgets/tracks_list.dart';

class ShowPlaylistPage extends StatefulWidget {
  const ShowPlaylistPage({super.key, required this.playlist});

  final Playlist playlist;
  final _service = const PlaylistService();
  final _trackService = const TrackService();

  @override
  State<ShowPlaylistPage> createState() => _ShowPlaylistPageState();
}

class _ShowPlaylistPageState extends State<ShowPlaylistPage> {
  List<Track>? _tracks;
  Playlist? _playlist;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ShowPlaylistBanner(playlist: _playlist ?? widget.playlist),
          TracksList(tracks: _tracks ?? [], updateTrack: updateTrack),
        ],
      ),
    );
  }

  void loadData() async {
    Playlist p = await widget._service.get(widget.playlist.id);

    setState(() {
      _playlist = p;
    });

    var tracks = await widget._trackService.list(p);

    setState(() {
      _tracks = tracks;
    });
  }

  void updateTrack(Track track) {
    setState(() {
      _tracks?[_tracks?.indexWhere((element) => element.id == track.id) ?? -1] =
          track;
    });
  }
}
