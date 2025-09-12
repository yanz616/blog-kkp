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

  Future<dynamic> deleteUsers(int id) async {
    final token = await LocalStorage.getString();
    if (token == null) {
      return ErrorResponse(
        success: false,
        statusCode: 404,
        message: "Token Tidak Ditemukan",
      );
    }
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/v1/users/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      Map<String, dynamic> jsonData;
      try {
        jsonData = jsonDecode(response.body);
      } catch (_) {
        return ErrorResponse(
          success: false,
          statusCode: response.statusCode,
          message: "Response bukan JSON valid",
        );
      }

      if (response.statusCode == 200) {
        return SuccessResponse.fromJson(jsonData, (data) => data.toString());
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
