// class User {
//   final int id;
//   final String name;
//   final String email;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       createdAt: json['created_at'] != null
//           ? DateTime.tryParse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? DateTime.tryParse(json['updated_at'])
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "name": name,
//       "email": email,
//       "created_at": createdAt?.toIso8601String(),
//       "updated_at": updatedAt?.toIso8601String(),
//     };
//   }

//   factory User.empty() {
//     return User(id: 0, name: '', email: '', createdAt: null, updatedAt: null);
//   }
// }
import 'package:intl/intl.dart';

class User {
  final int id;
  final String name;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }

  factory User.empty() {
    return User(id: 0, name: '', email: '', createdAt: null, updatedAt: null);
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
