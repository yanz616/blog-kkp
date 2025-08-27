// models/register_error_response.dart
class ErrorResponseModel {
  final bool status;
  final String message;
  final Map<String, List<String>> errors;

  ErrorResponseModel({
    required this.status,
    required this.message,
    required this.errors,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    final errors = <String, List<String>>{};
    if (json['errors'] != null) {
      json['errors'].forEach((key, value) {
        errors[key] = List<String>.from(value);
      });
    }
    return ErrorResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      errors: errors,
    );
  }
}
