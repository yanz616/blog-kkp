// import 'package:fe/data/helpers/date_time_helper.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String? avatar;
  final String? password;
  final String? token;
  final String? createdAt;
  final bool isAdmin;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.password,
    this.token,
    required this.createdAt,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // if (json['avatar'] == null) {
    //   json['avatar'] = "https://www.gstatic.com/webp/gallery/4.sm.webp";
    // }

    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
      token: json['token'],
      createdAt: json['createdAt']?.toString(),
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'password': password,
      'token': token,
      if (createdAt != null) 'createdAt': createdAt,
      'isAdmin': isAdmin,
    };
  }
}
