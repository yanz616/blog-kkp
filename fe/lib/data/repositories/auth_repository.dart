import 'dart:convert';
import 'package:fe/data/models/user/response/error_response_model.dart';
import 'package:fe/data/models/user/response/success_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:fe/core/constants/variabel.dart';
import 'package:fe/data/models/user/request/register_request_model.dart';

class AuthRepository {
  final String baseUrl = Variabel.baseUrl;

  Future<dynamic> register(RegisterRequestModel request) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        return SuccessResponseModel.fromJson(data);
      } else if (response.statusCode == 422) {
        return ErrorResponseModel.fromJson(data);
      } else {
        throw Exception("Unkwon Error : ${response.body}");
      }
    } catch (e) {
      throw Exception("Gagal Terhubung ke Server : $e");
    }
  }
}
