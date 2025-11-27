import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class RegisterRequest {
  final String username;
  final String email;
  final String password;
  final String passConfirmation;

  RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.passConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'password confirmation': passConfirmation,
    };
  }
}

class UpdateUserRequest {
  final String username;
  final XFile? avatar;
  final String? internshipStartDate;
  final String? internshipEndDate;
  final String? internshipPosition;
  final String? internshipDivision;
  final String? school;

  UpdateUserRequest({
    required this.username,
    this.avatar,
    this.internshipStartDate,
    this.internshipEndDate,
    this.internshipPosition,
    this.internshipDivision,
    this.school,
  });

  Map<String, String> toMap() {
    final map = <String, String>{'username': username};
    if (internshipStartDate != null) map['internshipStartDate'] = internshipStartDate!;
    if (internshipEndDate != null) map['internshipEndDate'] = internshipEndDate!;
    if (internshipPosition != null) map['internshipPosition'] = internshipPosition!;
    if (internshipDivision != null) map['internshipDivision'] = internshipDivision!;
    if (school != null) map['school'] = school!;
    return map;
  }

  // Untuk multipart (support Web & Mobile)
  Future<void> applyToMultipart(http.MultipartRequest request) async {
    request.fields['username'] = username;
    if (internshipStartDate != null) request.fields['internshipStartDate'] = internshipStartDate!;
    if (internshipEndDate != null) request.fields['internshipEndDate'] = internshipEndDate!;
    if (internshipPosition != null) request.fields['internshipPosition'] = internshipPosition!;
    if (internshipDivision != null) request.fields['internshipDivision'] = internshipDivision!;
    if (school != null) request.fields['school'] = school!;

    if (avatar != null) {
      final bytes = await avatar!.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'avatar',
        bytes,
        filename: avatar!.name,
      );
      request.files.add(multipartFile);
    }
  }
}
