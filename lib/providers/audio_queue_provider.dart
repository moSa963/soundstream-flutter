import 'package:just_audio/just_audio.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/provider.dart';


class AudioQueueProvider extends Provider {
  final List<Track> _queue;
  List<Track> get queue => _queue;

  final AudioPlayer _audio;
  AudioPlayer get audio => _audio;

  int? get index => _audio.currentIndex;

  Track? get track => _queue.elementAtOrNull(index ?? 0);

  late final ConcatenatingAudioSource _playlist;

  AudioQueueProvider() : _queue=[], _audio=AudioPlayer() {
    _playlist = ConcatenatingAudioSource(children: []);
    _init();
  }

  void _init() async {
    await _audio.setAudioSource(_playlist);
    notifyListeners();
  }

  void setList(List<Track> list, {int? index}) async {
    _queue.clear();
    _queue.addAll(list);
    _playlist.clear();
    await _playlist.addAll(_queue.map((v) => AudioSource.uri(v.uri)).toList());
    seekIndex(index ?? 0);
    notifyListeners();
  }

  void add(Track track) async {
    _queue.add(track);
    await _playlist.add(AudioSource.uri(track.uri));
    notifyListeners();
  }

  void remove(Track track) async {
    int index = _queue.indexOf(track);
    if (index == -1) return;
    _queue.removeAt(index);
    await _playlist.removeAt(index);
    notifyListeners();
  }

  @override
  void dispose() {
    _audio.dispose();
    super.dispose();
  }

  void backward() async {
    await _audio.seekToPrevious();
    notifyListeners();
  }

  void reset() async {
    await _audio.seek(Duration.zero);
  }

  void forward() async {
    await _audio.seekToNext();
    notifyListeners();
  }

  void seekIndex(int index) async {
    await _audio.seek(Duration.zero, index:  index);
    notifyListeners();
  }

  void seekTrack(Track track) {
    int index = _queue.indexOf(track);
    seekIndex(index);
  }
}

