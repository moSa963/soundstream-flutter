import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/lyrics.dart';
import 'package:soundstream_flutter/widgets/lyrics_viewer/lyrics_line.dart';

class LyricsList extends StatefulWidget {
  const LyricsList(
      {super.key,
      required this.lyrics,
      required this.position,
      this.setPosition});
  final Lyrics lyrics;
  final Duration position;
  final void Function(double? newPosition)? setPosition;

  @override
  State<LyricsList> createState() => _LyricsListState();
}

class _LyricsListState extends State<LyricsList> {
  final _key = GlobalKey();
  final _listkey = GlobalKey();
  final _controller = ScrollController();
  bool _inProgress = false;

  @override
  void didUpdateWidget(covariant LyricsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (_key.currentContext != null &&
          _listkey.currentContext != null &&
          !_inProgress) {
        _inProgress = true;
        final offset = (_key.currentContext!.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero,
                ancestor: _listkey.currentContext!.findRenderObject());

        if (offset.dy >= 50) {
          await _controller.animateTo(_controller.offset + offset.dy - 50,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        }
        _inProgress = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int selected = _getIndex();

    return ListView(
        key: _listkey,
        controller: _controller,
        shrinkWrap: true,
        children: _list(selected));
  }

  List<Widget> _list(int selected) {
    List<Widget> res = [];
    int counter = 0;

    for (int i = 0; i < widget.lyrics.lyrics.length; ++i) {
      final line = widget.lyrics.lyrics[i];
      if (line.isEmpty) {
        res.add(LyricsLine(line: line));
        continue;
      }

      var pos = widget.lyrics.timestamps.elementAtOrNull(++counter - 1);

      res.add(LyricsLine(
          key: selected == counter ? _key : null,
          line: line,
          selected: selected == counter,
          onTap: () => widget.setPosition?.call(pos)));
    }

    return res;
  }

  int _getIndex() {
    for (int i = 0; i < widget.lyrics.timestamps.length; ++i) {
      if (widget.position.inMilliseconds / 1000 < widget.lyrics.timestamps[i]) {
        return i;
      }
    }
    return -1;
  }
}
