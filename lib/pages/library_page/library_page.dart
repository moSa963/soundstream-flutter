import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/pages/library_page/library_page_appbar.dart';
import 'package:soundstream_flutter/pages/likes_page/likes_page.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';
import 'package:soundstream_flutter/widgets/list_item/list_item.dart';
import 'package:soundstream_flutter/widgets/list_item/playlist_item.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    var playlists = context.watch<PlaylistsProvider>().playlists;

    return Scaffold(
        appBar: const LibraryPageAppbar(),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            clipBehavior: Clip.none,
            children: [
              likedTracksItem(),
              Column(
                children: [
                  for (var playlist in playlists)
                    PlaylistItem(playlist: playlist),
                ],
              )
            ],
          ),
        ));
  }

  Widget likedTracksItem() {
    return ListItem(
      title: "Liked tracks",
      subtitle: "Playlist",
      leading: AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: Theme.of(context).colorScheme.primary.withAlpha(200),
          child: const Icon(Icons.favorite),
        ),
      ),
      onTap: () => _openLikesPage(),
    );
  }

  void _openLikesPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const LikesPage();
      },
    ));
  }

  Future<void> _handleRefresh() async {
    await context.read<PlaylistsProvider>().loadPlaylists();
  }
}
