import 'package:fe/data/models/user/user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  final User user;
  final bool success = true;

  AuthSuccess(this.message, this.user);
}

class AuthFailure extends AuthState {
  final String message;
  final bool success = false;

  AuthFailure(this.message);
}
