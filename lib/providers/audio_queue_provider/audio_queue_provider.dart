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

  PlayerState _state = PlayerState(false, ProcessingState.idle);
  PlayerState get state => _state;

  int? get index => _queue.index;

  Track? get track => _queue.track;

  AudioPlayer get player => _queue.player;

  late AudioProviderOptions options;

  AudioQueueProvider() {
    options = AudioProviderOptions(onChange: () => notifyListeners());

    _queue = TracksQueue(onChange: () async => notifyListeners());

    _queue.player.durationStream.listen((event) {
      _duration = event;
      notifyListeners();
    });

    _queue.player.positionStream.listen((event) {
      _position = event;
      notifyListeners();
    });

    _queue.player.playerStateStream.listen((event) async {
      _state = event;
      await _handleAudioEnd();
      notifyListeners();
    });

    _queue.player.currentIndexStream.listen((event) {
      notifyListeners();
    });
  }

  Future<void> _handleAudioEnd() async {
    if (_queue.player.playerState.processingState ==
        ProcessingState.completed) {
      if (options.repeatType == RepeatType.repeat) {
        await queue.forward();
      } else if (options.repeatType == RepeatType.repeatOne) {
        await seek(Duration.zero);
      }
    }
  }

  Future<void> reset() async {
    await _queue.player.seek(Duration.zero);
  }

  Future<void> seek(Duration pos) async {
    await _queue.player.seek(pos);
    _position = _queue.player.position;
    notifyListeners();
  }

  @override
  void dispose() async {
    await _queue.dispose();
    super.dispose();
  }
}
