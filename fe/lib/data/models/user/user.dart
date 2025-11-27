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
  final String? internshipStartDate;
  final String? internshipEndDate;
  final String? internshipPosition;
  final String? internshipDivision;
  final String? school;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.password,
    this.token,
    required this.createdAt,
    required this.isAdmin,
    this.internshipStartDate,
    this.internshipEndDate,
    this.internshipPosition,
    this.internshipDivision,
    this.school,
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
      internshipStartDate: json['internshipStartDate'],
      internshipEndDate: json['internshipEndDate'],
      internshipPosition: json['internshipPosition'],
      internshipDivision: json['internshipDivision'],
      school: json['school'],
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
      if (internshipStartDate != null) 'internshipStartDate': internshipStartDate,
      if (internshipEndDate != null) 'internshipEndDate': internshipEndDate,
      if (internshipPosition != null) 'internshipPosition': internshipPosition,
      if (internshipDivision != null) 'internshipDivision': internshipDivision,
      if (school != null) 'school': school,
    };
  }
}
