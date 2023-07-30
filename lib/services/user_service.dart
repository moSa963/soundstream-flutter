import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/services/api_service.dart';

class UserService {
  const UserService();
  final _api = const ApiService();

  Future<User> user(String username) async {
    final js = await _api.get("users/$username");
    return User.fromJson(js["data"]);
  }
}
