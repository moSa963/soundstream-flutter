import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/pages/player_page/player_page.dart';
import 'package:soundstream_flutter/pages/show_playlist_page/show_playlist_banner.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider.dart';
import 'package:soundstream_flutter/services/playlist_service.dart';
import 'package:soundstream_flutter/services/track_service.dart';
import 'package:soundstream_flutter/widgets/track_item.dart';

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
          for (var track in _tracks ?? [])
            TrackItem(
              key: Key(track.id.toString()),
              track: track,
              onTap: () => handleTap(track),
              updateTrack: updateTrack,
            ),
        ],
      ),
    );
  }

  void loadData() async {
    Playlist p = await widget._service.get(widget.playlist.id ?? 0);

    setState(() {
      _playlist = p;
    });

    var tracks = await widget._trackService.list(p);

    setState(() {
      _tracks = tracks;
    });
  }

  void handleTap(Track track) {
    context
        .read<AudioQueueProvider>()
        .setList(_tracks ?? [], index: _tracks?.indexOf(track));

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const PlayerPage();
      },
    ));
  }

  void updateTrack(Track track) {
    setState(() {
      _tracks?[_tracks?.indexWhere((element) => element.id == track.id)  ?? -1] = track;
    });
  }
}
