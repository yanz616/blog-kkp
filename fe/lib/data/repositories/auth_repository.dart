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
      print(jsonData);

      if (response.statusCode == 200) {
        final res = SuccessResponse<User>.fromJson(
          jsonData,
          (data) => User.fromJson(data),
        );

        final user = res.data;

        // ⬇ Tambahan: cek null agar tidak crash
        if (user.token != null) {
          await LocalStorage.setString(user.token!);
        }

        await LocalStorage.setId(user.id);
        await LocalStorage.setUsername(user.username ?? ""); // <-- Null-safe
        await LocalStorage.setEmail(user.email ?? ""); // <-- Null-safe
        await LocalStorage.setAvatar(user.avatar ?? ""); // <-- Null-safe
        await LocalStorage.setCreatedAt(user.createdAt ?? ""); // <-- Null-safe

        // ⬇ Field opsional disimpan hanya jika tidak null
        await LocalStorage.setIsAdmin(user.isAdmin ?? false); // <-- Null-safe

        if (user.internshipDivision != null) {
          await LocalStorage.setInternshipDivision(user.internshipDivision!);
        }
        if (user.internshipStartDate != null) {
          await LocalStorage.setInternshipStartDate(user.internshipStartDate!);
        }
        if (user.internshipEndDate != null) {
          await LocalStorage.setInternshipEndDate(user.internshipEndDate!);
        }
        if (user.internshipPosition != null) {
          await LocalStorage.setInternshipPosition(user.internshipPosition!);
        }
        if (user.school != null) {
          await LocalStorage.setSchool(user.school!);
        }

        return res;
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Terjadi kesalahan pada koneksi atau server. $e",
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
          (data) => User.fromJson(data),
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

  // Update user
  Future<dynamic> updateUser(UpdateUserRequest request, int id) async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception("Token Tidak Ditemukan");

    try {
      final uri = Uri.parse('$baseUrl/v1/users/$id');
      var multipartRequest = http.MultipartRequest('PUT', uri);

      // Header Authorization
      multipartRequest.headers['Authorization'] = 'Bearer $token';

      // Field wajib
      multipartRequest.fields['username'] = request.username;

      // Field opsional (NULL-safe)
      if (request.internshipStartDate != null) {
        multipartRequest.fields['internshipStartDate'] =
            request.internshipStartDate!;
      }

      if (request.internshipEndDate != null) {
        multipartRequest.fields['internshipEndDate'] =
            request.internshipEndDate!;
      }

      if (request.internshipPosition != null) {
        multipartRequest.fields['internshipPosition'] =
            request.internshipPosition!;
      }

      if (request.internshipDivision != null) {
        multipartRequest.fields['internshipDivision'] =
            request.internshipDivision!;
      }

      if (request.school != null) {
        multipartRequest.fields['school'] = request.school!;
      }

      // Upload avatar opsional
      if (request.avatar != null) {
        if (kIsWeb) {
          final bytes = await request.avatar!.readAsBytes();
          multipartRequest.files.add(
            http.MultipartFile.fromBytes(
              'avatar',
              bytes,
              filename: request.avatar!.name,
            ),
          );
        } else {
          multipartRequest.files.add(
            await http.MultipartFile.fromPath('avatar', request.avatar!.path),
          );
        }
      }

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

        // ⬇ Null-safe update LocalStorage
        await LocalStorage.setUsername(user.data.username ?? "");

        if (user.data.avatar != null) {
          await LocalStorage.setAvatar(user.data.avatar!);
        }
        if (user.data.internshipStartDate != null) {
          await LocalStorage.setInternshipStartDate(
            user.data.internshipStartDate!,
          );
        }
        if (user.data.internshipEndDate != null) {
          await LocalStorage.setInternshipEndDate(user.data.internshipEndDate!);
        }
        if (user.data.internshipPosition != null) {
          await LocalStorage.setInternshipPosition(
            user.data.internshipPosition!,
          );
        }
        if (user.data.internshipDivision != null) {
          await LocalStorage.setInternshipDivision(
            user.data.internshipDivision!,
          );
        }
        if (user.data.school != null) {
          await LocalStorage.setSchool(user.data.school!);
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
