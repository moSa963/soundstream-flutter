import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';

class UpdateProfileImageButton extends StatelessWidget {
  const UpdateProfileImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => _updateProfileImage(context),
        child: const Text("Update profile image"));
  }

  void _updateProfileImage(BuildContext context) async {
    FilePickerResult? res = await FilePicker.platform.pickFiles();

    if (res == null || !context.mounted) return;

    context.read<AuthProvider>().updateProfileImage(res.files[0]);
  }
}
