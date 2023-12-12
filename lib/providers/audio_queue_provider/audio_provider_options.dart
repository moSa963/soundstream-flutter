class AudioProviderOptions {
  AudioProviderOptions({required this.onChange});

  RepeatType _repeatType = RepeatType.repeat;
  RepeatType get repeatType => _repeatType;
  set repeatType(RepeatType repeatType) {
    _repeatType = repeatType;
    onChange.call();
  }

  SeekType _seekType = SeekType.linear;
  SeekType get seekType => _seekType;
  set seekType(SeekType type) {
    _seekType = type;
    onChange.call();
  }

  final void Function() onChange;
}

enum RepeatType { noRepeat, repeatOne, repeat }

enum SeekType { linear, random }
