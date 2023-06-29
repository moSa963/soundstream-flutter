import 'package:soundstream_flutter/models/playlist.dart';

class PlaylistService {
  Future<List<Playlist>> list() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        Playlist.fromJson({
          "id": 1,
          "title": "Title 1",
          "user": {
            "id": 1,
            "username": "usernane",
          },
          "album": false,
          "created_at": "2023-18-05",
          "description": "this is dfsd f",
          "liked": true,
          "private": false,
          "tracks_count": 5,
        }),
      ],
    );
  }

  Future<Playlist> get(int id) {
    return Future.delayed(
        const Duration(seconds: 2),
        () => Playlist(
              id: id,
              title: "Title",
            ));
  }

  Future<Playlist> create(Playlist playlist) {
    playlist.id = 12;
    return Future.delayed(const Duration(seconds: 2), () => playlist);
  }

  Future<Playlist> update(Playlist playlist) {
    return Future.delayed(const Duration(seconds: 2), () => playlist);
  }

  Future<void> destroy(Playlist playlist) {
    return Future.delayed(const Duration(seconds: 8));
  }
}
