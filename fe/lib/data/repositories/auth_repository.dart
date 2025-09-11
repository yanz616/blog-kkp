import 'dart:convert';
import 'package:fe/core/constants/variabel.dart';
import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/data/models/response/response_model.dart';
import 'package:fe/data/models/user/user.dart';
import 'package:flutter/foundation.dart';
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

      if (response.statusCode == 200) {
        final res = SuccessResponse<User>.fromJson(
          jsonData,
          (data) => User.fromJson(data),
        );
        await LocalStorage.setString(res.data.token!);
        await LocalStorage.setId(res.data.id);
        await LocalStorage.setUsername(res.data.username);
        await LocalStorage.setEmail(res.data.email);
        await LocalStorage.setAvatar(res.data.avatar ?? "");
        await LocalStorage.setCreatedAt(res.data.createdAt!);
        return res;
      } else {
        return ErrorResponse.fromJson(jsonData);
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
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Terjadi kesalahan pada koneksi atau server $e",
      );
    }
  }

  Future<dynamic> updateUser(UpdateUserRequest request, int id) async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception("Token Tidak Ditemukan");

    try {
      final uri = Uri.parse('$baseUrl/v1/users/$id');
      var multipartRequest = http.MultipartRequest('PUT', uri);

      // Header Authorization
      multipartRequest.headers['Authorization'] = 'Bearer $token';

      // Tambahkan field text
      multipartRequest.fields['username'] = request.username;

      // Tambahkan file avatar jika ada
      if (request.avatar != null) {
        if (kIsWeb) {
          // WEB: ambil bytes
          final bytes = await request.avatar!.readAsBytes();
          multipartRequest.files.add(
            http.MultipartFile.fromBytes(
              'avatar',
              bytes,
              filename: request.avatar!.name,
            ),
          );
        } else {
          // MOBILE: pakai path
          multipartRequest.files.add(
            await http.MultipartFile.fromPath('avatar', request.avatar!.path),
          );
        }
      }

      // Kirim request
      final streamedResponse = await multipartRequest.send();
      final response = await http.Response.fromStream(streamedResponse);

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
        final user = SuccessResponse<User>.fromJson(
          jsonData,
          (data) => User.fromJson(data),
        );
        await LocalStorage.setUsername(user.data.username);
        if (user.data.avatar != null) {
          await LocalStorage.setAvatar(user.data.avatar!);
        }
        return user;
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Terjadi kesalahan: ${e.toString()}",
      );
    }
  }
}
