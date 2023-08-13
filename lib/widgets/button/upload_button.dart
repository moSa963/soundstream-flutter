import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/widgets/dialog/upload_track_dialog.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key, this.album, this.onDone});
  final Playlist? album;
  final void Function(Track track)? onDone;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _openPicker(context),
      icon: const Icon(Icons.upload_file),
    );
  }

  void _openPicker(BuildContext context) async {
    FilePickerResult? res = await FilePicker.platform.pickFiles();

    if (res == null || album == null) return;

    if (context.mounted) {
      return _onUpload(context, res.files[0], album!);
    }
  }

  void _onUpload(BuildContext context, PlatformFile? file, Playlist album) {
    if (file == null) return;

    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: UploadTrackDialog(file: file, album: album, onDone: onDone),
          );
        });
  }
}
