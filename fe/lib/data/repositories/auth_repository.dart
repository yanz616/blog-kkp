// import 'dart:convert';
// import 'package:fe/core/constants/variabel.dart';
// import 'package:fe/data/models/request/auth_request.dart';
// import 'package:fe/data/models/response/auth_response.dart';
// import 'package:fe/data/models/user/user.dart';
// import 'package:http/http.dart' as http;

// class AuthRepository {
//   final String baseUrl = Variabel.baseUrl;

//   // Login
//   Future<dynamic> login(LoginRequest request) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       body: jsonEncode(request.toJson()),
//       headers: {'Content-Type': 'application/json'},
//     );

//     final jsonData = jsonDecode(response.body);

//     // Return SuccessResponse atau ErrorResponse langsung
//     if (jsonData['success'] == true) {
//       // print(jsonData['data']);
//       return SuccessResponse<User>.fromJson(
//         jsonData,
//         (json) => User.fromJson(json),
//       );
//     } else {
//       return ErrorResponse.fromJson(jsonData);
//     }
//   }

//   // Register
//   Future<dynamic> register(RegisterRequest request) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/register'),
//       body: jsonEncode(request.toJson()),
//       headers: {'Content-Type': 'application/json'},
//     );

//     final jsonData = jsonDecode(response.body);

//     if (jsonData['success'] == true) {
//       return SuccessResponse<User>.fromJson(
//         jsonData,
//         (json) => User.fromJson(json),
//       );
//     } else {
//       return ErrorResponse.fromJson(jsonData);
//     }
//   }
// }
// import 'dart:convert';

// import 'package:fe/core/constants/variabel.dart';
// import 'package:fe/data/models/request/auth_request.dart';
// import 'package:fe/data/models/response/auth_response.dart';
// import 'package:http/http.dart' as http;

// class AuthRepository {
//   final String baseUrl = Variabel.baseUrl;

//   // Login
//   Future<dynamic> login(LoginRequest request) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       body: jsonEncode(request.toJson()),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       if (jsonData['success'] == true) {
//         return SuccessResponse.fromJson(jsonData);
//       } else {
//         return ErrorResponse.fromJson(jsonData);
//       }
//     } else {
//       // fallback error jika HTTP error
//       return ErrorResponse(
//         success: false,
//         message: 'Server error: ${response.statusCode}',
//       );
//     }
//   }

//   // Register
//   Future<dynamic> register(RegisterRequest request) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/register'),
//       body: jsonEncode(request.toJson()),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       if (jsonData['success'] == true) {
//         return SuccessResponse.fromJson(jsonData);
//       } else {
//         return ErrorResponse.fromJson(jsonData);
//       }
//     } else {
//       return ErrorResponse(
//         success: false,
//         message: 'Server error: ${response.statusCode}',
//       );
//     }
//   }
// }
import 'dart:convert';
import 'package:fe/core/constants/variabel.dart';
import 'package:fe/data/models/request/auth_request.dart';
import 'package:fe/data/models/response/auth_response.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = Variabel.baseUrl;

  // Login
  Future<dynamic> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: jsonEncode(request.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //&& jsonData['success'] == true
        return SuccessResponse.fromJson(jsonData);
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      return ErrorResponse(
        success: false,
        message: "Terjadi kesalahan pada koneksi atau server.",
        errors: {
          "exception": [e.toString()],
        },
      );
    }
  }

  // Register
  Future<dynamic> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: jsonEncode(request.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonData['success'] == true) {
        return SuccessResponse.fromJson(jsonData);
      } else {
        return ErrorResponse.fromJson(jsonData);
      }
    } catch (e) {
      return ErrorResponse(
        success: false,
        message: "Terjadi kesalahan pada koneksi atau server.",
        errors: {
          "exception": [e.toString()],
        },
      );
    }
  }
}
