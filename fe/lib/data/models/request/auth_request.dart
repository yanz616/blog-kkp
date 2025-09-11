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

  UpdateUserRequest({required this.username, this.avatar});

  Map<String, String> toMap() {
    return {'username': username};
  }

  // Untuk multipart (support Web & Mobile)
  Future<void> applyToMultipart(http.MultipartRequest request) async {
    request.fields['username'] = username;

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
