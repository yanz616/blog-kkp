// class SuccessResponse<T> {
//   final bool success;
//   final String message;
//   final T data;

//   SuccessResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory SuccessResponse.fromJson(
//     Map<String, dynamic> json,
//     T Function(dynamic json) create,
//   ) {
//     return SuccessResponse<T>(
//       success: json['success'] ?? true,
//       message: json['message'] ?? '',
//       data: create(json['data']),
//     );
//   }
// }
import 'package:fe/data/models/user/user.dart';

class SuccessResponse {
  final bool success;
  final String message;
  final User data;

  SuccessResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(
      success: json['success'] ?? true,
      message: json['message'] ?? '',
      data: User.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class ErrorResponse {
  final bool success;
  final String message;
  final Map<String, List<String>> errors;

  ErrorResponse({
    required this.success,
    required this.message,
    Map<String, List<String>>? errors,
  }) : errors = errors ?? {};

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      errors: json['errors'] != null
          ? (json['errors'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, List<String>.from(value)),
            )
          : {},
    );
  }
}
