import 'dart:convert';
import 'package:fe/core/constants/variabel.dart';
import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/data/models/response/response_model.dart';
import 'package:fe/data/models/user/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = Variabel.baseUrl;

  // Login
  Future<dynamic> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/v1/login'),
        body: jsonEncode(request.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body);
      print(jsonData);

      if (jsonData['statusCode'] == 200 && jsonData['success'] == true) {
        return SuccessResponse<User>.fromJson(
          jsonData,
          (data) => User.fromJson(data),
        );
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      print(e);
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Terjadi kesalahan pada koneksi atau server.",
      );
    }
  }

  // Register
  Future<dynamic> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/v1/register'),
        body: jsonEncode(request.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body);

      if (jsonData['statusCode'] == 201 && jsonData['success'] == true) {
        return SuccessResponse<User>.fromJson(
          jsonData,
          (data) => User.fromJson(data), //callback untuk parsing data
        );
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Terjadi kesalahan pada koneksi atau server.",
      );
    }
  }
}
