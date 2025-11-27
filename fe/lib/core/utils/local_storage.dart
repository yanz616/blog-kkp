import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> setString(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getString() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> removeString() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<void> setId(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', value);
  }

  static Future<void> setUsername(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', value);
  }

  static Future<void> setEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', value);
  }

  static Future<void> setAvatar(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatar', value);
  }

  static Future<void> setCreatedAt(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('created', value);
  }

  static Future<void> setIsAdmin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAdmin', value);
  }

  static Future<int?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<String?> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('avatar');
  }

  static Future<String?> getCreated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('created');
  }

  static Future<bool?> getIsAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdmin');
  }

  static Future<void> removeId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
  }

  static Future<void> removeUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }

  static Future<void> removeEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }

  static Future<void> removeAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('avatar');
  }

  static Future<void> removeCreated() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('created');
  }

  static Future<void> removeIsAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isAdmin');
  }

  // Internship Start Date
  static Future<void> setInternshipStartDate(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('internshipStartDate', value);
  }

  static Future<String?> getInternshipStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('internshipStartDate');
  }

  static Future<void> removeInternshipStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('internshipStartDate');
  }

  // Internship End Date
  static Future<void> setInternshipEndDate(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('internshipEndDate', value);
  }

  static Future<String?> getInternshipEndDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('internshipEndDate');
  }

  static Future<void> removeInternshipEndDate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('internshipEndDate');
  }

  // Internship Position
  static Future<void> setInternshipPosition(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('internshipPosition', value);
  }

  static Future<String?> getInternshipPosition() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('internshipPosition');
  }

  static Future<void> removeInternshipPosition() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('internshipPosition');
  }

  // Internship Division
  static Future<void> setInternshipDivision(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('internshipDivision', value);
  }

  static Future<String?> getInternshipDivision() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('internshipDivision');
  }

  static Future<void> removeInternshipDivision() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('internshipDivision');
  }

  // School
  static Future<void> setSchool(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('school', value);
  }

  static Future<String?> getSchool() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('school');
  }

  static Future<void> removeSchool() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('school');
  }
}
