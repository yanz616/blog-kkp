import 'package:fe/data/models/request/auth_request.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginRequest request;

  LoginEvent(this.request);
}

class RegisterEvent extends AuthEvent {
  final RegisterRequest request;

  RegisterEvent(this.request);
}
