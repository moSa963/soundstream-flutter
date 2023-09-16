import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';
import 'package:soundstream_flutter/services/history_service.dart';
import 'package:soundstream_flutter/services/likes_service.dart';
import 'package:soundstream_flutter/widgets/list_item/playlist_item.dart';
import 'package:soundstream_flutter/widgets/list_item/track_item.dart';
import 'package:soundstream_flutter/widgets/text_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _likesService = const LikesService();
  final _historyService = const HistoryService();
  List<Track> _likedTracks = [];
  List<Track> _historyTracks = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    var playlists = context.watch<PlaylistsProvider>().playlists;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Sound Stream"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        body: ListView(clipBehavior: Clip.none, children: [
          const SizedBox(
            height: 10,
          ),
          const TextTitle("Your Playlsits"),
          Wrap(
            children: [
              for (int i = 0; i < playlists.length; ++i)
                if (i < 6)
                  FractionallySizedBox(
                      widthFactor: .5,
                      child: PlaylistItem(playlist: playlists[i])),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const TextTitle("You liked"),
          SizedBox(
            height: 150,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                for (var track in _likedTracks)
                  TrackItem(
                    track: track,
                    direction: Axis.horizontal,
                  )
              ],
            ),
          ),
          const TextTitle("Latest played"),
          SizedBox(
            height: 150,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                for (var track in _historyTracks)
                  TrackItem(
                    track: track,
                    direction: Axis.horizontal,
                  )
              ],
            ),
          ),
        ]));
  }

  void _loadData() async {
    var likedTracks = await _likesService.likedTracks(count: 4);

    setState(() {
      _likedTracks = likedTracks;
    });

    var historyTracks = await _historyService.list(count: 4);

    setState(() {
      _historyTracks = historyTracks;
    });
  }
}
