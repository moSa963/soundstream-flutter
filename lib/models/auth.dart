


import 'package:soundstream_flutter/models/user.dart';

class Auth extends User{
  String name;
  String email;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;

  Auth({
    required super.id,
    this.name = "",
    super.username = "",
    this.email = "",
    this.emailVerifiedAt,
    this.createdAt,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] == null ? DateTime.parse(json['email_verified_at'] as String) : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}