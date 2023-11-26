import 'package:file_picker/file_picker.dart';
import 'package:soundstream_flutter/models/auth.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class AuthService {
  final _api = const ApiService();

  const AuthService();

  Future<Auth> getUser() async {
    final js = await _api.get("user");
    return Auth.fromJson(js["data"]);
  }

  Future<Auth> register(
      {required String name,
      required String email,
      required String username,
      required String password,
      required String passwordConfirmation}) async {
    final js = await _api.post("register", {
      "name": name,
      "email": email,
      "username": username,
      "password": password,
      "password_confirmation": passwordConfirmation,
    });

    await _api.setToken(js["data"]["token"]);

    return Auth.fromJson(js["data"]["user"]);
  }

  Future<Auth> login(
      {required String username, required String password}) async {
    final js = await _api.post("login", {
      "username": username,
      "password": password,
    });

    await _api.setToken(js["data"]["token"]);

    return Auth.fromJson(js["data"]["user"]);
  }

  Future<void> logout() async {
    await _api.post("logout", {});
  }

  Future<User> image(User user, PlatformFile image) async {
    var js =
        await _api.multipartRequest("POST", "account/profile/photo", files: {
      "photo": image,
    });
    
    return User.fromJson(js["data"]);
  }
}
