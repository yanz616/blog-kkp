import 'dart:convert';

import 'package:fe/core/constants/variabel.dart';
import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/data/models/request/post_request.dart';
import 'package:fe/data/models/response/response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final String baseUrl = Variabel.baseUrl;

  Future<dynamic> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/v1/posts'),
        headers: {'Content-Type': 'application/json'},
      );
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return SuccessResponse<List<PostModel>>.fromJson(
          jsonData,
          (data) => (data as List).map((e) => PostModel.fromJson(e)).toList(),
        );
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: e.toString(),
      );
    }
  }

  Future<dynamic> fetchMyPosts() async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception("Token Not Found");
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/v1/me/posts'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final jsonData = jsonDecode(response.body);
      // print(jsonData);
      if (response.statusCode == 200) {
        return SuccessResponse<List<PostModel>>.fromJson(
          jsonData,
          (data) => (data as List).map((e) => PostModel.fromJson(e)).toList(),
        );
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      return ErrorResponse(
        success: false,
        statusCode: 500,
        message: "Tejadi Kesalahan koneksi server dan jaringan $e",
      );
    }
  }

  Future<dynamic> createPost(PostRequest request) async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception("Token Tidak Ditemukan");
    try {
      final uri = Uri.parse('$baseUrl/v1/posts');
      var multipartRequest = http.MultipartRequest('POST', uri);

      // Header Authorization
      multipartRequest.headers['Authorization'] = 'Bearer $token';

      // Tambahkan field text
      multipartRequest.fields['title'] = request.title;
      multipartRequest.fields['content'] = request.content;

      // Tambahkan file image jika ada
      if (request.image != null) {
        if (kIsWeb) {
          // WEB: ambil bytes
          final bytes = await request.image!.readAsBytes();
          multipartRequest.files.add(
            http.MultipartFile.fromBytes(
              'image',
              bytes,
              filename: request.image!.name,
            ),
          );
        } else {
          // MOBILE: pakai path
          multipartRequest.files.add(
            await http.MultipartFile.fromPath('image', request.image!.path),
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

      if (response.statusCode == 201) {
        return SuccessResponse<PostModel>.fromJson(
          jsonData,
          (data) => PostModel.fromJson(data),
        );
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

  Future<dynamic> updatePost(PostRequest request, int id) async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception("Token Tidak Ditemukan");

    try {
      final uri = Uri.parse('$baseUrl/v1/posts/$id');
      var multipartRequest = http.MultipartRequest('PUT', uri);

      // Header Authorization
      multipartRequest.headers['Authorization'] = 'Bearer $token';

      // Tambahkan field text
      multipartRequest.fields['title'] = request.title;
      multipartRequest.fields['content'] = request.content;

      // Tambahkan file image jika ada
      if (request.image != null) {
        if (kIsWeb) {
          // WEB: ambil bytes
          final bytes = await request.image!.readAsBytes();
          multipartRequest.files.add(
            http.MultipartFile.fromBytes(
              'image',
              bytes,
              filename: request.image!.name,
            ),
          );
        } else {
          // MOBILE: pakai path
          multipartRequest.files.add(
            await http.MultipartFile.fromPath('image', request.image!.path),
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
        return SuccessResponse<PostModel>.fromJson(
          jsonData,
          (data) => PostModel.fromJson(data),
        );
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

  //delete post
  Future<dynamic> deletePost(int id) async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception("Token Tidak Ditemukan");

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/v1/posts/$id'),
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
