import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/pages/profile_page/profile_page.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';
import 'package:soundstream_flutter/services/history_service.dart';
import 'package:soundstream_flutter/services/likes_service.dart';
import 'package:soundstream_flutter/widgets/horizontal_list.dart';
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
            IconButton(
                onPressed: () => _openPage(context, const ProfilePage()),
                icon: const Icon(Icons.settings))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _loadData,
          child: ListView(clipBehavior: Clip.none, children: [
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
            HorizontalList(
              title: "You liked",
              padding: const EdgeInsets.only(top: 25),
              children: [
                for (var track in _likedTracks)
                  TrackItem(
                    track: track,
                    direction: Axis.horizontal,
                  )
              ],
            ),
            HorizontalList(
              title: "Latest played",
              padding: const EdgeInsets.only(top: 25),
              children: [
                for (var track in _historyTracks)
                  TrackItem(
                    track: track,
                    direction: Axis.horizontal,
                  )
              ],
            ),
          ]),
        ));
  }

  Future<void> _loadData() async {
    var likedTracks = await _likesService.likedTracks(count: 6);

    if (mounted) {
      setState(() {
        _likedTracks = likedTracks;
      });
    }

    var historyTracks = await _historyService.list(count: 6);

    if (mounted) {
      setState(() {
        _historyTracks = historyTracks;
      });
    }
  }

  void _openPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ));
  }
}
