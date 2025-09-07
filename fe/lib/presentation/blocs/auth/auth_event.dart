import 'package:fe/data/models/request/auth_request.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginRequest loginRequest;

  LoginEvent(this.loginRequest);
}

class RegisterEvent extends AuthEvent {
  final RegisterRequest registerRequest;

  RegisterEvent(this.registerRequest);
}
