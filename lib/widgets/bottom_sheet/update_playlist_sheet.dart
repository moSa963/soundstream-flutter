import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';
import 'package:soundstream_flutter/utils/validator.dart';
import 'package:soundstream_flutter/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:soundstream_flutter/widgets/dialog/confirmation_dialog.dart';

class UpdatePlaylistSheet extends StatefulWidget {
  const UpdatePlaylistSheet({super.key, required this.playlist});
  final Playlist playlist;

  @override
  State<UpdatePlaylistSheet> createState() => _UpdatePlaylistSheetState();
}

class _UpdatePlaylistSheetState extends State<UpdatePlaylistSheet> {
  final _key = GlobalKey<FormState>();
  final Map<String, dynamic> inputs = {};

  @override
  void initState() {
    super.initState();
    inputs["private"] = widget.playlist.private;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetCard(
      progressing: context.watch<PlaylistsProvider>().loading,
      children: [
        Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              //Title field
              TextFormField(
                onChanged: (value) => _onChanged("title", value),
                initialValue: widget.playlist.title,
                decoration: _inputDecoration("title"),
                validator: (v) => Validator.validate(v,
                    max: 255,
                    min: 3,
                    regex: r"^[A-Za-z]+([ ._-]?[A-Za-z0-9]+)*$"),
              ),
              const SizedBox(height: 25),
              //Description field
              TextFormField(
                onChanged: (value) => _onChanged("description", value),
                initialValue: widget.playlist.description,
                decoration: _inputDecoration("description"),
                validator: (v) => Validator.validate(v, min: 8),
              ),
              const SizedBox(height: 25),
              //Private switch
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  const Text("Private: "),
                  Switch(
                      value: inputs["private"],
                      onChanged: (v) => _onChanged("private", v)),
                ],
              ),
              const SizedBox(height: 25),
              TextButton(
                onPressed: _handleUpdate,
                child: const Text("Save"),
              ),
              const Divider(),
              TextButton(
                  onPressed: _handleDelete,
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      label: Text(label),
    );
  }

  void _onChanged(String key, dynamic value) {
    setState(() {
      inputs.update(key, (_) => value, ifAbsent: () => value);
    });
  }

  void _handleUpdate() async {
    if (!(_key.currentState?.validate() ?? false)) return;

    await context.read<PlaylistsProvider>().updatePlaylist(Playlist.forUpdate(
          id: widget.playlist.id,
          title: inputs["title"],
          description: inputs["description"],
          private: inputs["private"],
        ));

    if (context.mounted) Navigator.pop(context);
  }

  void _handleDelete() async {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: "Delete playlist",
          subtitle:
              "Are you sure you want to permanently delete this playlist?",
          onConfirmed: () async {
            await context
                .read<PlaylistsProvider>()
                .deletePlaylist(widget.playlist);

            if (context.mounted) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}
