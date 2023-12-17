import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_queue_provider.dart';
import 'package:soundstream_flutter/services/likes_service.dart';
import 'package:soundstream_flutter/widgets/button/like_button.dart';
import 'package:soundstream_flutter/widgets/list_item/horizontal_list_item.dart';
import 'package:soundstream_flutter/widgets/list_item/list_item.dart';

class TrackItem extends StatelessWidget {
  final _service = const LikesService();
  final bool withHero;
  final Track track;
  final void Function(Track track)? updateTrack;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Axis direction;

  const TrackItem(
      {super.key,
      required this.track,
      this.onTap,
      this.onLongPress,
      this.updateTrack,
      this.direction = Axis.vertical,
      this.withHero = false});

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return HorizontalListItem(
        onLongPress: onLongPress,
        onTap: onTap ?? () => _handleTap(context),
        leading: _leading(),
        title: track.title,
        subtitle: track.album?.title ?? "",
        actions: _actions(),
      );
    }

    return ListItem(
      onLongPress: onLongPress,
      onTap: onTap,
      leading: _leading(),
      title: track.title,
      subtitle: track.album?.title ?? "",
      actions: _actions(),
    );
  }

  List<Widget> _actions() {
    return [
      LikeButton(
        liked: track.liked,
        onChange: _like,
      ),
    ];
  }

  Widget _leading() {
    return AspectRatio(
        aspectRatio: 1,
        child: withHero
            ? Hero(tag: "track ${track.id}", child: _image())
            : _image());
  }

  Widget _image() {
    return Image.network(
      track.imgUri.toString(),
      fit: BoxFit.cover,
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

  void _handleTap(BuildContext context) {
    context.read<AudioQueueProvider>().queue.setList([track]);
  }
}
