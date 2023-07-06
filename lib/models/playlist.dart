import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class Playlist {
  int? id;
  User? user;
  String title;
  String description;
  bool album;
  DateTime? createdAt;
  bool liked;
  int tracksCount;
  bool private;

  Uri get imgUri => ApiService.uri("playlists/$id/photo");

  Playlist({
    this.id,
    this.title = "",
    this.description = "",
    this.album = false,
    this.liked = false,
    this.private = true,
    this.tracksCount = 0,
    this.user,
    this.createdAt,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      album: json['album'] as bool,
      liked: json['liked'] as bool,
      private: json['private'] as bool,
      tracksCount: json['tracks_count'] as int? ?? 0,
      user: User.fromJson(json['user']),
      createdAt: DateTime.tryParse(json['created_at']),
    );
  }
  
}
