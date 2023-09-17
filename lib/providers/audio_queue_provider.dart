import 'package:just_audio/just_audio.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/provider.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class AudioQueueProvider extends Provider {
  final api = const ApiService();

  List<Track> _queue;
  List<Track> get queue => _queue;

  Duration? _duration;
  Duration? get duration => _duration;

  Duration? _position;
  Duration? get position => _position;

  final AudioPlayer _player;
  AudioPlayer get player => _player;

  PlayerState _state = PlayerState(false, ProcessingState.idle);
  PlayerState get state => _state;

  int? _index;
  int? get index => _index;

  Track? get track => index == null ? null : _queue.elementAtOrNull(index!);

  AudioQueueProvider()
      : _queue = [],
        _player = AudioPlayer() {
    _player.durationStream.listen((event) {
      _duration = event;
      notifyListeners();
    });

    _player.positionStream.listen((event) {
      _position = event;
      notifyListeners();
    });

    _player.playerStateStream.listen((event) {
      _state = event;
      notifyListeners();
    });
  }

  Future<void> setList(List<Track> list, {int index = 0}) async {
    _queue = list;

    await setIndex(index);

    notifyListeners();
  }

  Future<void> setIndex(int index) async {
    if (_queue.isEmpty) {
      _index = null;
      return;
    }

    _index = index % _queue.length;

    await _handleIndexChanged();
  }

  Future<void> _handleIndexChanged() async {
    await _player.stop();
    
    if (index == null) return;

    await api.setAudioPlayerUrl(_player, _queue[index!].uri.toString());
    await _player.play();
  }

  Future<void> add(Track track) async {
    _queue.add(track);
    notifyListeners();
  }

  Future<void> remove(Track track) async {
    int index = _queue.indexOf(track);
    if (index == -1) return;
    _queue.removeAt(index);
    if (_index == index) return;
    await setIndex(_index ?? 0);
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  Future<void> backward() async {
    await setIndex((_index ?? 0) - 1);
    notifyListeners();
  }

  Future<void> reset() async {
    await _player.seek(Duration.zero);
  }

  Future<void> forward() async {
    await setIndex((_index ?? 0) + 1);
    notifyListeners();
  }

  Future<void> seekTrack(Track track) async {
    int index = _queue.indexOf(track);
    await setIndex(index);
  }

  void updateTrack(Track track) {
    int index = _queue.indexOf(track);

    if (index == -1) return;

    _queue[index] = track;
    notifyListeners();
  }
}
