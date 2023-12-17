import 'package:just_audio/just_audio.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_provider_options.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/tracks_queue.dart';
import 'package:soundstream_flutter/providers/provider.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class AudioQueueProvider extends Provider {
  final api = const ApiService();

  late final TracksQueue _queue;
  TracksQueue get queue => _queue;
  SeekType get seekType => _queue.seekType;
  set seekType(SeekType type) {
    _queue.seekType = type;
  }

  Duration? _duration;
  Duration? get duration => _duration;

  Duration? _position;
  Duration? get position => _position;

  final AudioPlayer _player = AudioPlayer();
  AudioPlayer get player => _player;

  PlayerState _state = PlayerState(false, ProcessingState.idle);
  PlayerState get state => _state;

  int? get index => _queue.index;

  Track? _track;
  Track? get track => _track;

  late AudioProviderOptions options;

  AudioQueueProvider() {
    options = AudioProviderOptions(onChange: () => notifyListeners());

    _queue = TracksQueue(onChange: () async {
      if (_queue.getTrack()?.id != track?.id) {
        _track = _queue.getTrack();
        await _handleIndexChanged();
      }

      notifyListeners();
    });

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

  Future<void> _handleIndexChanged() async {
    await _player.stop();

    if (index == null) return;

    await api.setAudioPlayerUrl(_player, track!.uri.toString());
    await _player.play();
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  Future<void> reset() async {
    await _player.seek(Duration.zero);
  }

  Future<void> seek(Duration pos) async {
    player.seek(pos);
    _position = player.position;
    notifyListeners();
  }
}
