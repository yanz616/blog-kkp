// models/register_request.dart
class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation, // sesuai rule Laravel
    };
  }
}
