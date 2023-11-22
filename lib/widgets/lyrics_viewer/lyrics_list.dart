import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/lyrics.dart';
import 'package:soundstream_flutter/widgets/lyrics_viewer/lyrics_line.dart';

class LyricsList extends StatefulWidget {
  const LyricsList({super.key, required this.lyrics, required this.position});
  final Lyrics lyrics;
  final Duration position;

  @override
  State<LyricsList> createState() => _LyricsListState();
}

class _LyricsListState extends State<LyricsList> {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: _list(),
    );
  }

  List<LyricsLine> _list() {
    final res = <LyricsLine>[];
    final index = _getIndex();
    int counter = 0;

    for (var line in widget.lyrics.lyrics) {
      if (line.isEmpty) {
        res.add(LyricsLine(line: line));
        continue;
      }

      res.add(LyricsLine(
        key: index == counter ? _key : null,
        line: line,
        selected: index == counter,
      ));
      ++counter;
    }

    return res;
  }

  int _getIndex() {
    for (int i = 0; i < widget.lyrics.timestamps.length; ++i) {
      if (widget.position.inSeconds <= widget.lyrics.timestamps[i]) {
        return i - 1;
      }
    }
    return -1;
  }
}
