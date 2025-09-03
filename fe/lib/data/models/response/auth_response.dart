import 'package:fe/data/models/user/user.dart';

class SuccessResponse {
  final bool success;
  final int statusCode;
  final String message;
  final User data;

  SuccessResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(
      success: json['success'] ?? true,
      statusCode: json['statusCode'],
      message: json['message'] ?? '',
      data: User.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statuCode': statusCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ErrorResponse {
  final bool success;
  final int statusCode;
  final String message;

  ErrorResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'],
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'statuCode': statusCode, 'message': message};
  }
}
