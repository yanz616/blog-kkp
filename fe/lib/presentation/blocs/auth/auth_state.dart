import 'package:fe/data/models/user/user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  final User user;

  AuthSuccess(this.message, this.user);
}

// class AuthFailure extends AuthState {
//   final String message;
//   final dynamic errors;

//   AuthFailure(this.message, {this.errors});
// }
class AuthFailure extends AuthState {
  final String message;
  final Map<String, List<String>> errors;

  AuthFailure(this.message, {this.errors = const {}});
}
