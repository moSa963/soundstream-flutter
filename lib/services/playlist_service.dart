import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class PlaylistService {
  const PlaylistService();
  final api = const ApiService();

  Future<List<Playlist>> list() async {
    final js = await api.get("playlists");
    return (js["data"] as List<dynamic>).map((v) => Playlist.fromJson(v)).toList();
  }

  Future<Playlist> get(int id) async {
    final js = await api.get("playlists/$id");
    return Playlist.fromJson(js["data"]);
  }

  Future<Playlist> create(Playlist playlist) async {
    final js = await api.post("playlists", {
      if (playlist.title != null) "title": playlist.title,
    });

    return Playlist.fromJson(js["data"]);
  }

  Future<Playlist> update(Playlist playlist) async {

    final js = await api.post("playlists/${playlist.id}", {
      if (playlist.title != null) "title": playlist.title,
      if (playlist.description != null) "description": playlist.description,
      if (playlist.private != null) "private": playlist.private,
    });

    return Playlist.fromJson(js["data"]);
  }

  Future<void> destroy(Playlist playlist) async {
    await api.delete("playlists/${playlist.id}");
  }
}
