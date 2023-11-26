import 'package:file_picker/file_picker.dart';
import 'package:soundstream_flutter/models/auth.dart';
import 'package:soundstream_flutter/models/playlist.dart';
import 'package:soundstream_flutter/models/track.dart';
import 'package:soundstream_flutter/models/user.dart';
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

  Future<void> register(
      {required String name,
      required String email,
      required String username,
      required String password,
      required String passwordConfirmation}) async {
    await withLoading(() async {
      auth = await service.register(
          name: name,
          email: email,
          username: username,
          password: password,
          passwordConfirmation: passwordConfirmation);
    });
  }

  Future<void> login(
      {required String username, required String password}) async {
    await withLoading(() async {
      auth = await service.login(username: username, password: password);
    });
  }

  Future<void> logout() async {
    await withLoading(() async {
      await service.logout();
      auth = null;
    });
  }

  Future<void> updateProfileImage(PlatformFile image) async {
    if (auth == null) return;
    User user = await service.image(auth!, image);
    auth?.image = user.image;
    notifyListeners();
  }

  bool ownedPlaylist(Playlist playlist) {
    return auth?.username != null && auth?.username == playlist.user?.username;
  }

  bool ownedTrack(Track track) {
    return auth?.username != null && auth?.username == track.user?.username;
  }
}
