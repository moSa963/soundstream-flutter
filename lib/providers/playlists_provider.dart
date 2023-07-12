import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/providers/provider.dart';
import 'package:soundstream_flutter/services/playlist_service.dart';

class PlaylistsProvider extends Provider {
  final List<Playlist> _playlists;
  List<Playlist> get playlists => _playlists;

  final PlaylistService service;

  PlaylistsProvider({required this.service}) : _playlists = [] {
    loadPlaylists();
  }

  Future<void> loadPlaylists() async {
    await withLoading(() async {
      var res = await service.list();
      _playlists.clear();
      _playlists.addAll(res);
    });
  }

  Future<void> createPlaylist(Playlist playlist) async {
    assert(playlist.id == -1);

    await withLoading(() async {
      var res = await service.create(playlist);
      _playlists.add(res);
    });
  }

  void addPlaylist(Playlist playlist) {
    assert(playlist.id != -1);
    if (playlists.where((element) => element.id == playlist.id).isNotEmpty) {
      return;
    }

    playlists.add(playlist);
    notifyListeners();
  }

  Future<void> deletePlaylist(Playlist playlist) async {
    assert(playlist.id != -1);

    await withLoading(() async {
      await service.destroy(playlist);
      _playlists.removeWhere((element) => element.id == playlist.id);
    });
  }

  void removePlaylist(Playlist playlist) {
    assert(playlist.id != -1);
    playlists.removeWhere((element) => element.id == playlist.id);
    notifyListeners();
  }

  Future<void> updatePlaylist(Playlist playlist) async {
    await withLoading(() async {
      late Playlist res;

      res = await service.update(playlist);

      int index = _playlists.indexWhere(
        (element) => element.id == playlist.id,
      );

      if (index == -1) return;

      _playlists[index] = res;
    });
  }
}
