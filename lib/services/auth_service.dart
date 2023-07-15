import 'package:soundstream_flutter/models/auth.dart';
import 'package:soundstream_flutter/services/api_service.dart';




class AuthService {
  final api = const ApiService();

  const AuthService();

  Future<Auth?> getUser() async {
    try{
      final js = await api.get("user");
      return Auth.fromJson(js["data"]);
    } catch(_) {
      return null;
    }
  }

}
