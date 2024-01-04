import 'package:just_audio/just_audio.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/services/api_service.dart';

enum SeekType { linear, random }

class TracksQueue {
  TracksQueue({required this.onChange});
  final _api = const ApiService();

  List<Track> _list = [];
  List<Track> get list => _list;

  final AudioPlayer _player = AudioPlayer();
  AudioPlayer get player => _player;

  int? get index => list.isEmpty ? null : _player.currentIndex;

  final Future<void> Function() onChange;

  SeekType _seekType = SeekType.linear;

  SeekType get seekType => _seekType;

  Track? get track => index == null ? null : _list[index!];

  set seekType(SeekType type) {
    if (type == _seekType) return;
    _seekType = type;
    _setSeekType(type);
  }

  Future<void> _setSeekType(SeekType newType) async {
    _player.setShuffleModeEnabled(newType == SeekType.random);
    await onChange.call();
  }

  Future<void> backward() async {
    await _player.seekToPrevious();
    await onChange.call();
  }

  Future<void> forward() async {
    await _player.seekToNext();
    await onChange.call();
  }

  Future<void> setList(List<Track> list, {int? index}) async {
    if (list.isEmpty) {
      await _clear();
    } else {
      await _addList(list, initialIndex: index);
    }
    await onChange.call();
  }

  Future<void> _addList(List<Track> list, {int? initialIndex}) async {
    _list = list;
    final List<AudioSource> s = [];

    for (int i = 0; i < list.length; ++i) {
      s.add(await _api.audioSource(list[i].uri, tag: list[i].toMediaItem()));
    }

    await _player.stop();
    await player.setAudioSource(ConcatenatingAudioSource(children: s),
        initialIndex: initialIndex);
  }

  Future<void> _clear() async {
    _list = [];
    await _player.setAudioSource(ConcatenatingAudioSource(children: []));
    await _player.stop();
  }

  Future<void> add(Track track) async {
    final list = _player.audioSource as ConcatenatingAudioSource;
    _list.add(track);
    await list.add(await _api.audioSource(track.uri));
    return await onChange.call();
  }

  Future<void> remove(Track track) async {
    int index = _list.indexOf(track);
    if (index == -1) return;

    if (_list.length == 1) {
      return _clear();
    }

    final audioSource = _player.audioSource as ConcatenatingAudioSource;

    if ((_player.currentIndex ?? 0) >= _list.length - 1) {
      await _player.seek(Duration.zero, index: _list.length - 2);
    }
    _list.removeAt(index);
    await audioSource.removeAt(index);

    await onChange.call();
  }

  Future<void> update(Track track) async {
    int index = list.indexOf(track);

    if (index == -1) return;

    list[index] = track;

    return await onChange.call();
  }

  Future<void> seekTrack(Track track) async {
    int i = list.indexOf(track);
    await seekIndex(i);
    await onChange.call();
  }

  Future<void> seekIndex(int i) async {
    if (i < 0 || i >= list.length) {
      return;
    }

    await _player.seek(Duration.zero, index: i);
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
