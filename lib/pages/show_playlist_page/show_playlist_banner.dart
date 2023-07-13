import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/widgets/page_banner.dart';
import 'package:soundstream_flutter/widgets/bottom_sheet/update_playlist_sheet.dart';

class ShowPlaylistBanner extends StatelessWidget {
  const ShowPlaylistBanner({super.key, required this.playlist});
  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return PageBanner(
      title: playlist.title ?? "",
      subtitle: playlist.description ?? "",
      image: Image.network( playlist.imgUri.toString(), fit: BoxFit.contain, ),
      leading: [
          IconButton(onPressed: () => _onUpdate(context), icon: const Icon(Icons.edit)),
      ],
    );
  }

  void _onUpdate(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) {
      return UpdatePlaylistSheet(playlist: playlist);
    });
  }
}
