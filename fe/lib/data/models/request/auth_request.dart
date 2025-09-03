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
