import 'package:soundstream_flutter/models/user.dart';



class Playlist{
  int? id;
  User? user;
  String title;
  String description;
  bool album;
  DateTime? createdAt;
  bool liked;
  int tracksCount;
  bool private;
  String get imgSrc => 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';

  Playlist({
    this.id,
    this.title="",
    this.description="",
    this.album=false,
    this.liked=false,
    this.private=true,
    this.tracksCount=0,
    this.user,
    this.createdAt,
  });

}