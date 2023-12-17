import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/pages/player_page/player_page.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/audio_player/audio_play_button.dart';
import 'package:soundstream_flutter/widgets/audio_player/audio_progress_bar.dart';
import 'package:soundstream_flutter/widgets/list_item/track_item.dart';
import 'package:soundstream_flutter/widgets/movable_box.dart';

class AudioPlayerBar extends StatelessWidget {
  const AudioPlayerBar({super.key});
  static double audioPlayerBarHight = 60;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AudioQueueProvider>();

    return MovableBox(
      onPanEnd: (e) => onPanEnd(context, e),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        margin: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(100),
                blurRadius: 10,
              )
            ]),
        child: Container(
            color: Theme.of(context).colorScheme.secondary.withAlpha(50),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                          child: TrackItem(
                              onTap: () => _openPlayerPage(context),
                              track: provider.track ?? Track(),
                              withHero: false)),
                      const AudioPlayButton(),
                    ],
                  ),
                ),
                const AudioProgressBar(
                  noLabels: true,
                  noSeek: true,
                  trackHeight: 3,
                )
              ],
            )),
      ),
    );
  }

  void _openPlayerPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const PlayerPage();
      },
    ));
  }

  void onPanEnd(BuildContext context, DragEndDetails e) {
    if (e.velocity.pixelsPerSecond.dy > 1000) {
      context.read<AudioQueueProvider>().queue.setList([]);
    }
  }
}
