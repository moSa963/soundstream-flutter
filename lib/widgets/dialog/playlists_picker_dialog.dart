import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';
import 'package:soundstream_flutter/widgets/dialog/dialog_layout.dart';
import 'package:soundstream_flutter/widgets/list_item/playlist_item.dart';
import 'package:soundstream_flutter/widgets/timed_text_field.dart';

class PlaylistPickerDialog extends StatefulWidget {
  const PlaylistPickerDialog({super.key, this.onPicked, this.filter});
  final void Function(Playlist playlist)? onPicked;
  final bool Function(User? authUser, Playlist playlist)? filter;

  @override
  State<PlaylistPickerDialog> createState() => _PlaylistPickerDialogState();
}

class _PlaylistPickerDialogState extends State<PlaylistPickerDialog> {
  String _searchValue = "";

  @override
  Widget build(BuildContext context) {
    var playlists = context.watch<PlaylistsProvider>().playlists;

    return DialogLayout(
      children: [
        TimedTextField(
          hintText: "Search",
          duration: const Duration(milliseconds: 100),
          onChange: (value) => setState(() {
            _searchValue = value;
          }),
        ),
        const Divider(),
        for (var playlist in playlists)
          if ((playlist.title?.contains(_searchValue) ?? true) &&
              (widget.filter
                      ?.call(context.watch<AuthProvider>().auth, playlist) ??
                  true))
            PlaylistItem(playlist: playlist, onTap: () => widget.onPicked?.call(playlist),),
      ],
    );
  }
}
