import 'package:file_picker/file_picker.dart';
import 'package:soundstream_flutter/models/lyrics.dart';
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

  Future<Track> updateImage(Track track, PlatformFile image) async {
    final js =
        await api.multipartRequest("POST", "tracks/${track.id}/photo", files: {
      "photo": image,
    });

    return Track.fromJson(js["data"]);
  }

  Future<Lyrics> lyrics(Track track) async {
    try {
      final js = await api.get("lyrics/tracks/${track.id}");
      return Lyrics.fromJson(js["data"]);
    } catch (_) {
      return Lyrics();
    }
  }
}
