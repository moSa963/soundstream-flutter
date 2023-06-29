import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/services/playlist_service.dart';

class PlaylistsProvider with ChangeNotifier {
  final List<Playlist> _playlists;
  List<Playlist> get playlists => _playlists;

  bool _loading;
  bool get loading => _loading;

  final PlaylistService service;

  PlaylistsProvider({required this.service})
      : _playlists = [],
        _loading = false {
          loadPlaylists();
        }

  void loadPlaylists() async {
    _loading = true;
    var res = await service.list();
    _playlists.clear();
    _playlists.addAll(res);
    _loading = false;
    notifyListeners();
  }

  void createPlaylist(Playlist playlist) async {
    assert(playlist.id == null);
    _loading = true;
    var res = await service.create(playlist);
    _playlists.add(res);
    _loading = false;
    notifyListeners();
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
    _loading = true;
    await service.destroy(playlist);
    _loading = false;

    _playlists.remove(playlist);
  }

  void removePlaylist(Playlist playlist) {
    assert(playlist.id != null);
    playlists.removeWhere((element) => element.id == playlist.id);
    notifyListeners();
  }

  void updatePlaylist(Playlist playlist) async {
    assert(playlist.id != null);
    _loading = true;

    var res = await service.update(playlist);

    int index = _playlists.indexOf(playlist);

    if (index == -1) return;

    _playlists[index] = res;
    _loading = false;

    notifyListeners();
  }
}
