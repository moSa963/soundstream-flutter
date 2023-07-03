import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';

class CreatePlaylistPage extends StatefulWidget {
  const CreatePlaylistPage({super.key});

  @override
  State<CreatePlaylistPage> createState() => _CreatePlaylistPageState();
}

class _CreatePlaylistPageState extends State<CreatePlaylistPage> {
  final Map<String, dynamic> inputs = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create playlist"),
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
    context.read<PlaylistsProvider>().createPlaylist(Playlist(title: inputs["title"]));
    Navigator.of(context).pop();
  }
}
