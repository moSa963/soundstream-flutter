import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/upload_provider.dart';

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
    final v = context.read<UploadProvider>();

    FilePickerResult? res = await FilePicker.platform.pickFiles();

    if (res == null || album == null) return;

    final t = await v.uploadTrack(res.files[0], album ?? Playlist());
    onDone?.call(t);
  }
}
