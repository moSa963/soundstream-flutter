import 'package:soundstream_flutter/services/api_service.dart';

class User {
  int? id;
  String username;

  Uri get imgUri => ApiService.uri("account/$username/profile/photo");

  User({
    this.id,
    this.username = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      username: json['username'] as String,
    );
  }
}
