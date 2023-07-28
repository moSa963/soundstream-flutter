import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/services/search_service.dart';
import 'package:soundstream_flutter/widgets/list_item/playlist_item.dart';
import 'package:soundstream_flutter/widgets/list_item/user_item.dart';
import 'package:soundstream_flutter/widgets/timed_text_field.dart';
import 'package:soundstream_flutter/widgets/tracks_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  final _service = const SearchService();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Track> _tracks = [];
  List<Playlist> _playlists = [];
  List<User> _users = [];
  String _filter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TimedTextField(
            hintText: "Search",
            onChange: (value) => _loadData(value),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Wrap(
              spacing: 4,
              children: [
                _chip("tracks"),
                _chip("playlists"),
                _chip("users"),
              ],
            ),
          )),
      body: ListView(
        children: [
          if (_filter.isEmpty || _filter == "tracks")
            TracksList(tracks: _tracks),
          if (_filter.isEmpty || _filter == "playlists")
            for (final playlist in _playlists) PlaylistItem(playlist: playlist),
          if (_filter.isEmpty || _filter == "users")
            for (final user in _users) UserItem(user: user),
        ],
      ),
    );
  }

  void _loadData(String key) async {
    if (key.isEmpty) return setEmpty();

    final data = await widget._service.search(key);

    setState(() {
      _tracks = data["tracks"] as List<Track>;
      _playlists = data["playlists"] as List<Playlist>;
      _playlists += data["albums"] as List<Playlist>;
      _users = data["users"] as List<User>;
    });
  }

  void setEmpty() {
    setState(() {
      _tracks = [];
      _playlists = [];
      _playlists = [];
      _users = [];
    });
  }

  Widget _chip(String name) {
    return ActionChip(
        label: Text(name),
        shape: const StadiumBorder(),
        backgroundColor: _filter == name
            ? Theme.of(context).colorScheme.primary.withAlpha(100)
            : null,
        onPressed: () => _handleChipPressed(name));
  }

  void _handleChipPressed(String filter) {
    setState(() {
      _filter = filter == _filter ? "" : filter;
    });
  }
}
