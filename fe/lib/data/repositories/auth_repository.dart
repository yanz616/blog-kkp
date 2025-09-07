import 'dart:convert';
import 'package:fe/core/constants/variabel.dart';
import 'package:fe/data/models/dummy/dummy_model.dart';
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
      // final response = await http.post(
      //   Uri.parse('$baseUrl/v1/login'),
      //   body: jsonEncode(request.toJson()),
      //   headers: {'Content-Type': 'application/json'},
      // );

      // final jsonData = jsonDecode(response.body);

      final matchedUser = dummyUsers.firstWhere(
        (u) => u.email == request.email && u.password == request.password,
        orElse: () => User(
          id: -1,
          username: "",
          email: "",
          avatar: "",
          token: "",
          password: "",
          createdAt: "",
        ),
      );

      if (matchedUser.id != -1) {
        return SuccessResponse<User>(
          success: true,
          statusCode: 200,
          message: message,
          data: matchedUser,
        );
      } else {
        return ErrorResponse(
          success: false,
          statusCode: 400,
          message: errorMessage,
        );
      }

      // if (jsonData['statusCode'] == 200 && jsonData['success'] == true) {
      //   return SuccessResponse<User>.fromJson(
      //     jsonData,
      //     // (data) => User.fromJson(data),
      //     (data) => user,
      //   );
      // } else {
      //   return ErrorResponse.fromJson(jsonData);
      //   return ErrorResponse(
      //     success: false,
      //     statusCode: 400,
      //     message: errorMessage,
      //   );
      // }
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
