import 'package:soundstream_flutter/models/auth.dart';
import 'package:soundstream_flutter/providers/provider.dart';
import 'package:soundstream_flutter/services/auth_service.dart';

class AuthProvider extends Provider {
  Auth? auth;
  final AuthService service;

  AuthProvider({required this.service}) {
    _loadUser();
  }

  void _loadUser() {
    withLoading(() async {
      auth = await service.getUser();
    });
  }
}
