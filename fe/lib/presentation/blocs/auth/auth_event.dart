import 'package:fe/data/models/request/auth_request.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginRequest loginRequest;

  LoginEvent(this.loginRequest);
}

class RegisterEvent extends AuthEvent {
  RegisterRequest registerRequest;

  RegisterEvent(this.registerRequest);
}
