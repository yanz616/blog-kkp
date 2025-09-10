import 'dart:convert';
import 'package:fe/core/constants/variabel.dart';
import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/data/models/response/response_model.dart';
import 'package:fe/data/models/user/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = Variabel.baseUrl;
  var message = "Login Berhasil ";
  var errorMessage = "Login gagal";

  // Login
  Future<dynamic> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/v1/login'),
        body: jsonEncode(request.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body);

      if (jsonData['statusCode'] == 200 && jsonData['success'] == true) {
        final res = SuccessResponse<User>.fromJson(
          jsonData,
          (data) => User.fromJson(data),
        );
        await LocalStorage.setString(res.data.token!);
        await LocalStorage.setId(res.data.id);
        await LocalStorage.setUsername(res.data.username);
        await LocalStorage.setEmail(res.data.email);
        await LocalStorage.setAvatar(res.data.avatar ?? "");
        await LocalStorage.setCreatedAt(res.data.createdAt);
        return res;
      } else {
        return ErrorResponse.fromJson(jsonData);
        // return ErrorResponse(
        //   success: false,
        //   statusCode: 400,
        //   message: errorMessage,
        // );
      }
    } catch (e) {
      // print(e);
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

      if (response.statusCode == 201) {
        return SuccessResponse<User>.fromJson(
          jsonData,
          (data) => User.fromJson(data), //callback untuk parsing data
        );
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      print(e);
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Terjadi kesalahan pada koneksi atau server $e",
      );
    }
  }
}
