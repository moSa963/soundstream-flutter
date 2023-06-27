import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/user.dart';



class Track{
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

  Track({
    this.id,
    this.title="",
    this.writtenBy="",
    this.performedBy="",
    this.album,
    this.liked=false,
    this.explicit=true,
    this.duration=0,
    this.user,
    this.createdAt,
    this.addedAt,
  });

}