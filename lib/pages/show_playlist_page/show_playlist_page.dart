import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/pages/page_layout.dart';
import 'package:soundstream_flutter/pages/show_playlist_page/show_playlist_banner.dart';
import 'package:soundstream_flutter/providers/upload_provider.dart';
import 'package:soundstream_flutter/services/track_service.dart';
import 'package:soundstream_flutter/widgets/list_item/uploading_item.dart';
import 'package:soundstream_flutter/widgets/tracks_list.dart';

class ShowPlaylistPage extends StatefulWidget {
  const ShowPlaylistPage({super.key, required this.playlist});

  final Playlist playlist;
  final _trackService = const TrackService();

  @override
  State<ShowPlaylistPage> createState() => _ShowPlaylistPageState();
}

class _ShowPlaylistPageState extends State<ShowPlaylistPage> {
  List<Track>? _tracks;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final uploadingTracks =
        context.watch<UploadProvider>().tracksInProgress(widget.playlist);

    return PageLayout(
      body: ListView(
        children: [
          ShowPlaylistBanner(
            playlist: widget.playlist,
            onTrackAdded: _handleTrackAdded,
          ),
          ...?uploadingTracks
              ?.map<UploadingItem>((e) => UploadingItem(
                    title: e.title,
                  ))
              .toList(),
          TracksList(
              tracks: _tracks ?? [],
              updateTrack: _updateTrack,
              playlist: widget.playlist),
        ],
      ),
    );
  }

  void loadData() async {
    var tracks = await widget._trackService.list(widget.playlist);

    setState(() {
      _tracks = tracks;
    });
  }

  void _updateTrack(Track track) {
    setState(() {
      _tracks?[_tracks?.indexWhere((element) => element.id == track.id) ?? -1] =
          track;
    });
  }

  void _handleTrackAdded(Track track) {
    setState(() {
      _tracks?.add(track);
    });
  }
}
