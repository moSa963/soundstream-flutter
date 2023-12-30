import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => _logout(context),
        child: const Text(
          "Logout",
          style: TextStyle(color: Colors.red),
        ));
  }

  void _logout(BuildContext context) async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    await context.read<AuthProvider>().logout();
  }
}
