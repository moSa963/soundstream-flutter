import 'package:file_picker/file_picker.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class UploadService {
  final _api = const ApiService();

  const UploadService();

  Future<Track> uploadTrack(Playlist playlist, PlatformFile track, String name) async {
    final js = await _api.multipartRequest("POST", "tracks/albums/${playlist.id}", files: {"track": track}, fields: {"title": name});
    return Track.fromJson(js["data"]);
  }

}
