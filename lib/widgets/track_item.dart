import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/services/likes_service.dart';
import 'package:soundstream_flutter/widgets/like_button.dart';
import 'package:soundstream_flutter/widgets/list_item.dart';

class TrackItem extends StatelessWidget {
  final _service = const LikesService();
  final Track track;
  final void Function(Track track)? updateTrack;
  final void Function()? onTap;

  const TrackItem({super.key, required this.track, this.onTap, this.updateTrack});

  @override
  Widget build(BuildContext context) {
    return ListItem(
      onTap: onTap,
      leading: Image.network(
          track.imgUri.toString(),
          fit: BoxFit.contain,
        ),
        title: track.title,
        subtitle: track.album?.title ?? "",
        actions:  [
          LikeButton(liked: track.liked, onChange: _like,),
        ],
    );
  }


  void _like(bool newValue) async {
    if (newValue) {
      await _service.likeTrack(track);
    } else {
      await _service.unlikeTrack(track);
    }

    track.liked = newValue;
    updateTrack?.call(track);
  }
}
