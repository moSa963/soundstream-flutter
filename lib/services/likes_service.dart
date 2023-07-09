
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class LikesService {
  const LikesService();
  final api = const ApiService();

  Future<List<Track>> likedTracks() async {
    final js = await api.get("likes");
    return (js["data"] as List<dynamic>).map((v) => Track.fromJson(v)).toList();
  }

  Future<void> likeTrack(Track track) async {
    await api.post("likes/tracks/${track.id}", null);
  }

  Future<void> unlikeTrack(Track track) async {
    await api.delete("likes/tracks/${track.id}");
  }

  Future<void> likePlaylist(Playlist playlist) async {
    await api.post("likes/playlists/${playlist.id}", null);
  }

  Future<void> unlikePlaylist(Playlist playlist) async {
    await api.delete("likes/playlists/${playlist.id}");
  }

}
