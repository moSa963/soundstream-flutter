import 'package:soundstream_flutter/services/api_service.dart';

class User {
  int? id;
  String username;
  String name;
  DateTime? createdAt;

  Uri get imgUri => ApiService.uri("account/$username/profile/photo");

  User({
    this.id,
    this.createdAt,
    this.username = "",
    this.name = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String? ?? "",
      username: json['username'] as String,
      createdAt: DateTime.tryParse(json['created_at'] ?? ""),
    );
  }
}
