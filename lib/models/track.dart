import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class Track {
  int? id;
  User? user;
  String title;
  String writtenBy;
  String performedBy;
  Playlist? album;
  DateTime? createdAt;
  DateTime? addedAt;
  bool liked;
  int duration;
  bool explicit;
  String? image;

  Uri get uri => ApiService.uri("tracks/$id/stream");


  Uri get imgUri => ApiService.uri("tracks/$id/photo/$image");

  Track({
    this.id,
    this.title = "",
    this.writtenBy = "",
    this.performedBy = "",
    this.album,
    this.image,
    this.liked = false,
    this.explicit = true,
    this.duration = 0,
    this.user,
    this.createdAt,
    this.addedAt,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'] as int,
      title: json['title'] as String,
      writtenBy: json['written_by'] as String,
      performedBy: json['performed_by'] as String,
      album: json['album'] != null ? Playlist.fromJson(json['album']) : null,
      explicit: json['explicit'] as bool,
      image: json['image'] as String?,
      liked: json['liked'] as bool,
      duration: json['duration'] as int,
      user: User.fromJson(json['user']),
      createdAt: DateTime.tryParse(json['created_at']),
      addedAt: DateTime.tryParse(json['added_at']),
    );
  }
}
