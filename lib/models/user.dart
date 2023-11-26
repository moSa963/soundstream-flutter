import 'package:soundstream_flutter/services/api_service.dart';

class User {
  int? id;
  String username;
  String name;
  DateTime? createdAt;
  String? image;

  Uri get uri => ApiService.uri("tracks/$id/stream");

  Uri get imgUri => ApiService.uri("account/$username/profile/photo/$image");

  User({
    this.id,
    this.createdAt,
    this.username = "",
    this.name = "",
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String? ?? "",
      username: json['username'] as String,
      image: json['photo'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] ?? ""),
    );
  }
}
