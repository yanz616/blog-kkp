import 'package:intl/intl.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String? password;
  final bool isAdmin;
  final String token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.password,
    required this.isAdmin,
    required this.token,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      password: json['password'],
      isAdmin: json['is_admin'] == false,
      token: json['token'],
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'password': password,
      'is_admin': isAdmin,
      'token': token,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Helper untuk parsing tanggal dengan fallback
  static DateTime? _parseDate(dynamic dateStr) {
    if (dateStr == null) return null;

    try {
      // coba parse ISO8601 langsung
      return DateTime.tryParse(dateStr.toString());
    } catch (_) {
      try {
        // fallback ke format Laravel "yyyy-MM-dd HH:mm:ss"
        return DateFormat(
          "yyyy-MM-dd HH:mm:ss",
        ).parse(dateStr.toString(), true).toLocal();
      } catch (_) {
        return null; // kalau gagal semua, biarkan null
      }
    }
  }
}
