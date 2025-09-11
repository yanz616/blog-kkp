import 'dart:convert';

import 'package:fe/core/constants/variabel.dart';
import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/models/response/response_model.dart';
import 'package:fe/data/models/user/user.dart';
import 'package:http/http.dart' as http;

class AdminRepository {
  final String baseUrl = Variabel.baseUrl;

  Future<dynamic> fetchUsers() async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception("Token Tidak Ditemukan");
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/v1/users'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return SuccessResponse<List<User>>.fromJson(
          jsonData,
          (data) => (data as List).map((e) => User.fromJson(e)).toList(),
        );
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Terjadi Kesalahan $e",
      );
    }
  }
}
