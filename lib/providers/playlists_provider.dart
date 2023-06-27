import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';

class PlaylistsProvider with ChangeNotifier {
  final List<Playlist> _playlists;
  List<Playlist> get playlists => _playlists;

  PlaylistsProvider() : _playlists = [];

  void loadPlaylists() async {
    //TODO
    throw UnimplementedError();
  }

  void createPlaylist(Playlist playlist) async {
    assert(playlist.id == null);
    //TODO
    throw UnimplementedError();
  }

  void addPlaylist(Playlist playlist) {
    assert(playlist.id != null);
    if (playlists.where((element) => element.id == playlist.id).isNotEmpty) {
      return;
    }

    playlists.add(playlist);
    notifyListeners();
  }

  void deletePlaylist(Playlist playlist) async {
    assert(playlist.id != null);

    //TODO
    throw UnimplementedError();
  }

  void removePlaylist(Playlist playlist) {
    assert(playlist.id != null);
    playlists.removeWhere((element) => element.id == playlist.id);
    notifyListeners();
  }

  void updatePlaylist(Playlist playlist) async {
    assert(playlist.id != null);

    //TODO
    throw UnimplementedError();
  }
}
