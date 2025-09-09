import 'dart:convert';

import 'package:fe/core/constants/variabel.dart';
import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/data/models/request/post_request.dart';
import 'package:fe/data/models/response/response_model.dart';
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
        print(response.body);
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
        print("FetchMyPosts status: ${response.statusCode}");
        print("FetchMyPosts body: ${response.body}");
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
    try {
      final token = await LocalStorage.getString();
      if (token == null) {
        return ErrorResponse(
          success: false,
          statusCode: 401,
          message: "Token tidak ditemukan",
        );
      }

      final uri = Uri.parse('$baseUrl/v1/posts');
      var multipartRequest = http.MultipartRequest('POST', uri);

      // Header Authorization
      multipartRequest.headers['Authorization'] = 'Bearer $token';

      // Tambahkan field text
      multipartRequest.fields['title'] = request.title;
      multipartRequest.fields['content'] = request.content;

      // Tambahkan file image jika ada
      if (request.image != null) {
        multipartRequest.files.add(
          await http.MultipartFile.fromPath(
            'image', // key harus sesuai backend
            request.image!.path,
          ),
        );
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

      final statusCode = jsonData['statusCode'];
      // is int
      //         ? jsonData['statusCode']
      //         : response.statusCode;
      print(jsonData);

      if (statusCode == 200 || statusCode == 201) {
        print(jsonData);
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
}
