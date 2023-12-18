import 'dart:math';

import 'package:soundstream_flutter/models/track.dart';

enum SeekType { linear, random }

class TracksQueue {
  TracksQueue({required this.onChange}) {
    _setSeed();
  }

  List<Track> _list = [];
  List<Track> get list => _list;

  int _start = 0;

  int? _pointer;

  int? get index => _getIndex();

  int _seed = 0;

  final Future<void> Function() onChange;

  SeekType _seekType = SeekType.linear;

  SeekType get seekType => _seekType;

  set seekType(SeekType type) {
    if (type == _seekType) return;
    _seekTypeChanged(_seekType, type);
    _seekType = type;
  }

  int? _getIndex() {
    if (_pointer == null) return null;

    if (_seekType == SeekType.linear) {
      return _pointer == null ? null : _pointer! % _list.length;
    }

    return _pointer == _start ? _start : _getRandomIndex(_pointer!);
  }

  Future<void> _seekTypeChanged(SeekType oldType, SeekType newType) async {
    if (oldType == SeekType.random) {
      _pointer = _getIndex();
    } else {
      _setSeed();
      _start = (_pointer ?? 0) % -list.length;
    }

    return onChange.call();
  }

  void _setSeed() {
    _seed = Random().nextInt(99999999);
  }

  int _getRandomIndex(int key) {
    final rand = Random(_seed);
    int res = 0;

    for (int i = 0; i <= key.abs(); ++i) {
      res = rand.nextInt(_list.length);
    }

    return res;
  }

  Future<void> _setPointer(int value, {bool reset = false}) async {
    final newPointer = _list.isEmpty ? null : value;

    _pointer = newPointer;

    if (reset) {
      _start = value;
    }

    return onChange.call();
  }

  Future<void> backward() async {
    return _setPointer((_pointer ?? 0) - 1);
  }

  Future<void> forward() async {
    return _setPointer((_pointer ?? 0) + 1);
  }

  Future<void> setList(List<Track> list, {int? index}) async {
    _list = list;
    _start = index ?? 0;
    return _setPointer(index ?? 0);
  }

  Track? getTrack() {
    return _pointer == null ? null : _list[index!];
  }

  Future<void> add(Track track) async {
    list.add(track);
    return onChange.call();
  }

  Future<void> remove(Track track) async {
    int index = list.indexOf(track);
    if (index == -1) return;
    list.removeAt(index);
    return _setPointer(_pointer ?? 0);
  }

  Future<void> update(Track track) async {
    int index = list.indexOf(track);

    if (index == -1) return;

    list[index] = track;

    return onChange.call();
  }

  Future<void> seekTrack(Track track) async {
    int index = list.indexOf(track);
    if (index == -1) return;
    return _setPointer(index, reset: true);
  }
}
