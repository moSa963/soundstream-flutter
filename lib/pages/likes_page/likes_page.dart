import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/services/likes_service.dart';
import 'package:soundstream_flutter/widgets/page_banner.dart';
import 'package:soundstream_flutter/widgets/list_item/track_item.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({super.key});

  @override
  State<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  List<Track>? _tracks;
  final _service = const LikesService();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          PageBanner(
            title: "Likes",
            image: AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Theme.of(context).colorScheme.primary.withAlpha(200),
                child: const Icon(Icons.favorite, size: 99),
              ),
            ),
          ),
          for (var track in _tracks ?? [])
            TrackItem(track: track, onTap: () => handleTap(track)),
        ],
      ),
    );
  }

  void loadData() async {
    var tracks = await _service.likedTracks();

    setState(() {
      _tracks = tracks;
    });
  }

  void handleTap(Track track) {
    
  }
}
