import 'package:just_audio/just_audio.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/provider.dart';

class AudioQueueProvider extends Provider {
  final List<Track> _queue;
  List<Track> get queue => _queue;

  final AudioPlayer _player;
  AudioPlayer get player => _player;

  int? get index => _player.currentIndex;

  Track? get track => index == null ? null : _queue.elementAtOrNull(index!);

  final ConcatenatingAudioSource _playlist;

  AudioQueueProvider()
      : _queue = [],
        _player = AudioPlayer(),
        _playlist = ConcatenatingAudioSource(children: []) {
    _player.setAudioSource(_playlist);
  }

  Future<void> setList(List<Track> list, {int? index}) async {
    _queue.clear();
    _queue.addAll(list);
    await _playlist.clear();
    await _playlist.addAll(_queue.map((v) => AudioSource.uri(v.uri)).toList());
    await _player.seek(Duration.zero, index: index);
    notifyListeners();
  }

  Future<void> add(Track track) async {
    _queue.add(track);
    await _playlist.add(AudioSource.uri(track.uri));
    notifyListeners();
  }

  Future<void> remove(Track track) async {
    int index = _queue.indexOf(track);
    if (index == -1) return;
    _queue.removeAt(index);
    await _playlist.removeAt(index);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  Future<void> backward() async {
    await _player.seekToPrevious();
    notifyListeners();
  }

  Future<void> reset() async {
    await _player.seek(Duration.zero);
  }

  Future<void> forward() async {
    await _player.seekToNext();
    notifyListeners();
  }

  Future<void> seekIndex(int index) async {
    await _player.seek(Duration.zero, index: index);
    notifyListeners();
  }

  Future<void> seekTrack(Track track) async {
    int index = _queue.indexOf(track);
    await seekIndex(index);
  }

  void updateTrack(Track track) {
    int index = _queue.indexOf(track);

    if (index == -1) return;

    _queue[index] = track;
    notifyListeners();
  }
}
