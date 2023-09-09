import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class TrackService {
  const TrackService();
  final api = const ApiService();

  Future<List<Track>> list(Playlist playlist) async {
    final js = await api.get("playlists/${playlist.id}/tracks");
    return (js["data"] as List<dynamic>).map((v) => Track.fromJson(v)).toList();
  }

  Future<List<Track>> likes() async {
    final js = await api.get("likes");
    return (js["data"] as List<dynamic>).map((v) => Track.fromJson(v)).toList();
  }

  Future<void> destroy(Track track) async {
    await api.delete("tracks/${track.id}");
  }

  Future<void> removeFromPlaylist(Playlist playlist, Track track) async {
    await api.delete("playlists/${playlist.id}/tracks/${track.id}");
  }

  Future<void> addToPlaylist(Playlist playlist, Track track) async {
    await api.post("playlists/${playlist.id}/tracks/${track.id}", {});
  }
}
