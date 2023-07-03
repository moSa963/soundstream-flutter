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

  Future<Track> create(Playlist playlist) async {
    final js = await api.post("tracks/albums/${playlist.id}", {
      //TODO
    });

    return Track.fromJson(js["data"]);
  }

  Future<void> destroy(Track track) async {
    await api.delete("tracks/${track.id}");
  }
}
