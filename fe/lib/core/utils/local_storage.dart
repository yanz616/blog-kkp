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
}
