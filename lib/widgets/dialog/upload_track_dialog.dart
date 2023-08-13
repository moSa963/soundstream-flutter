import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/providers/upload_provider.dart';

class UploadTrackDialog extends StatefulWidget {
  const UploadTrackDialog({super.key, required this.file, required this.album, this.onDone});
  final Playlist album;
  final PlatformFile file;
  final void Function(Track track)? onDone;
  
  @override
  State<UploadTrackDialog> createState() => _UploadTrackDialogState();
}

class _UploadTrackDialogState extends State<UploadTrackDialog> {
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Text(
                widget.file.name,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(),
              TextField(
                onChanged: (value) => (title = value),
                decoration: const InputDecoration(
                  label: Text("Title..."),
                  border: OutlineInputBorder(),
                ),
              ),
              TextButton(onPressed: _handleUpload, child: const Text("upload")),
            ],
          ),
        ),
      ),
    );
  }

  void _handleUpload() async {
    final v = context.read<UploadProvider>();
    Navigator.pop(context);
    
    final t = await v.uploadTrack(widget.file, widget.album, title: title.isEmpty ? widget.file.name : title);
    widget.onDone?.call(t);
  }
}
