class User {
  int? id;
  String username;

  User({
    this.id,
    this.username = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
    );
  }
}
