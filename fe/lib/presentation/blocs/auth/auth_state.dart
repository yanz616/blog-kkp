import 'package:fe/data/models/user/user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  final String message;

  AuthSuccess(this.user, this.message);
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
