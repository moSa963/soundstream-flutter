import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/pages/page_layout.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';

class CreateAlbumPage extends StatefulWidget {
  const CreateAlbumPage({super.key});

  @override
  State<CreateAlbumPage> createState() => _CreateAlbumPageState();
}

class _CreateAlbumPageState extends State<CreateAlbumPage> {
  final Map<String, dynamic> inputs = {};

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      appBar: AppBar(
        title: const Text("Create Album"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            titleTextField(),
            const SizedBox(height: 10),
            TextButton(onPressed: _onCreate, child: const Text("Create")),
          ]),
        ),
      ),
    );
  }

  Widget titleTextField() {
    return TextField(
      decoration: const InputDecoration(
        label: Text("Title..."),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) =>
          inputs.update("title", (v) => value, ifAbsent: () => value),
    );
  }

  void _onCreate() async {
    context.read<PlaylistsProvider>().createPlaylist(Playlist(title: inputs["title"]), album: true);
    Navigator.of(context).pop();
  }
}
