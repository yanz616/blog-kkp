import 'package:fe/data/models/user/user_model.dart';

class SuccessResponseModel {
  final bool status;
  final String message;
  final UserModel user;

  SuccessResponseModel({
    required this.status,
    required this.message,
    required this.user,
  });

  factory SuccessResponseModel.fromJson(Map<String, dynamic> json) {
    return SuccessResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      user: UserModel.fromJson(json['data']),
    );
  }
}
