import 'dart:convert';
import 'package:fe/core/constants/variabel.dart';
import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/models/posts/post_model.dart';
import 'package:fe/data/models/request/post_request.dart';
import 'package:fe/data/models/response/response_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final String baseUrl = Variabel.baseUrl;

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

      final jsonData = jsonDecode(response.body);

      final statusCode = jsonData['statusCode'] ?? response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
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
