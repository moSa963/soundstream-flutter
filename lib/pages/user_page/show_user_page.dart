import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/pages/page_layout.dart';
import 'package:soundstream_flutter/pages/user_page/user_page_header.dart';
import 'package:soundstream_flutter/services/likes_service.dart';
import 'package:soundstream_flutter/services/playlist_service.dart';
import 'package:soundstream_flutter/services/user_service.dart';
import 'package:soundstream_flutter/widgets/horizontal_list.dart';
import 'package:soundstream_flutter/widgets/list_item/playlist_item.dart';
import 'package:soundstream_flutter/widgets/list_item/track_item.dart';

class ShowUserPage extends StatefulWidget {
  const ShowUserPage({super.key, required this.username});
  final String username;

  @override
  State<ShowUserPage> createState() => _ShowUserPageState();
}

class _ShowUserPageState extends State<ShowUserPage> {
  final _likesService = const LikesService();
  final _playlistService = const PlaylistService();
  final _userService = const UserService();

  User? _user;
  List<Track> _likedTracks = [];
  List<Playlist> _playlists = [];
  List<Playlist> _albums = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      body: ListView(
        children: [
          UserPageHeader(user: _user ?? User(username: widget.username)),
          HorizontalList(
            title: "You liked",
            children: [
              for (var track in _likedTracks)
                TrackItem(
                  track: track,
                  direction: Axis.horizontal,
                )
            ],
          ),
          HorizontalList(
            title: "Playlists",
            padding: const EdgeInsets.only(top: 25),
            children: [
              for (var track in _playlists)
                PlaylistItem(
                  playlist: track,
                  direction: Axis.horizontal,
                )
            ],
          ),
          HorizontalList(
            title: "Albums",
            padding: const EdgeInsets.only(top: 25),
            children: [
              for (var track in _albums)
                PlaylistItem(
                  playlist: track,
                  direction: Axis.horizontal,
                )
            ],
          ),
        ],
      ),
    );
  }

  void _loadData() async {
    final user = await _userService.user(widget.username);
    setState(() {
      _user = user;
    });

    var likedTracks = await _likesService.likedTracks(user: user, count: 6);

    setState(() {
      _likedTracks = likedTracks;
    });

    var playlists = await _playlistService.list(user: user);

    setState(() {
      _playlists =
          playlists.where((element) => !(element.album ?? true)).toList();
      _albums = playlists.where((element) => element.album ?? false).toList();
    });
  }
}
