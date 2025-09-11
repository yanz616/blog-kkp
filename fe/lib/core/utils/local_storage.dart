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
}
