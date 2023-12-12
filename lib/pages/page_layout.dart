import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_queue_provider.dart';
import 'package:soundstream_flutter/widgets/audio_player/audio_player_bar.dart';

class PageLayout extends StatelessWidget {
  const PageLayout(
      {super.key, required this.body, this.appBar, this.bottomNavigationBar});
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Expanded(child: body),
          if (context.watch<AudioQueueProvider>().index != null)
            const AudioPlayerBar()
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
