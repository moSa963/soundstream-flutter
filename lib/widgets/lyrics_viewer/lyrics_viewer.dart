import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/lyrics.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/services/track_service.dart';
import 'package:soundstream_flutter/widgets/lyrics_viewer/lyrics_list.dart';

class LyricsViewer extends StatefulWidget {
  const LyricsViewer({super.key, this.track, this.position = Duration.zero});
  final Track? track;
  final Duration position;
  final service = const TrackService();

  @override
  State<LyricsViewer> createState() => _LyricsViewerState();
}

class _LyricsViewerState extends State<LyricsViewer> {
  Lyrics? lyrics;

  @override
  void initState() {
    super.initState();
    loadLyrics();
  }

  @override
  void didUpdateWidget(covariant LyricsViewer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.track?.id != widget.track?.id) {
      setState(() {
        lyrics = null;
      });

      loadLyrics();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 300),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withAlpha(50),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: LyricsList(lyrics: lyrics ?? Lyrics(), position: widget.position),
    );
  }

  void loadLyrics() async {
    if (widget.track == null) return;

    final data = await widget.service.lyrics(widget.track!);

    setState(() {
      lyrics = data;
    });
  }
}
