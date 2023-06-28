import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/widgets/list_item.dart';

class TrackItem extends StatelessWidget {
  final Track track;

  const TrackItem({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return ListItem(
      leading: Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          fit: BoxFit.contain,
        ),
        title: track.title,
        subtitle: track.album?.title ?? "",
    );
  }
}
