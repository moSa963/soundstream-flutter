import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundstream_flutter/models/track.dart';


class AudioQueueProvider extends ChangeNotifier {
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

  void setList(List<Track> list) async {
    _queue.clear();
    _queue.addAll(list);
    _playlist.clear();
    await _playlist.addAll(_queue.map((v) => AudioSource.uri(Uri.parse(v.url))).toList());
    notifyListeners();
  }

  void add(Track track) async {
    _queue.add(track);
    await _playlist.add(AudioSource.uri(Uri.parse(track.url)));
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
}
