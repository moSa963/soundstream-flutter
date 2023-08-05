import 'package:file_picker/file_picker.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/provider.dart';
import 'package:soundstream_flutter/services/upload_service.dart';

class UploadProvider extends Provider {
  final _service = const UploadService();
  final Map<int, List<Track>> _files;

  UploadProvider() : _files = {};

  Future<Track> uploadTrack(PlatformFile track, Playlist playlist,
      {String? title}) async {
    Track tr = Track(title: title ?? track.name);

    _files.putIfAbsent(playlist.id, () => []);

    _files[playlist.id]?.add(tr);

    notifyListeners();

    try {
      final res =
          await _service.uploadTrack(playlist, track, title ?? track.name);

      return res;
    } finally {
      _files[playlist.id]?.remove(tr);
      notifyListeners();
    }
  }

  List<Track>? tracksInProgress(Playlist playlist) {
    return _files[playlist.id];
  }
}
