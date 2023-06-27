import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';
import 'package:soundstream_flutter/widgets/playlist_item.dart';


class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}


class _LibraryPageState extends State<LibraryPage> {


  @override
  Widget build(BuildContext context) {
    var playlists = context.watch<PlaylistsProvider>().playlists;

    return ListView(
      children: [
        for(var playlist in playlists) PlaylistItem(playlist: playlist)
      ],
    );
  }
}