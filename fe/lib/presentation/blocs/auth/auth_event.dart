import 'package:fe/data/models/request/auth_request.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginRequest request;

  LoginEvent(this.request);
}

class RegisterEvent extends AuthEvent {
  RegisterRequest registerRequest;

  RegisterEvent(this.registerRequest);
}
