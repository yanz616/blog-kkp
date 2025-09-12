import 'package:fe/data/models/user/user.dart';

abstract class AdminState {
  const AdminState();
}

class InitialAdminState extends AdminState {
  const InitialAdminState();
}

class LoadingAdminState extends AdminState {
  const LoadingAdminState();
}

class LoadedUsers extends AdminState {
  final String message;
  final List<User> users;

  const LoadedUsers(this.message, this.users);
}

class SuccessDeleteUser extends AdminState {
  final String message;

  const SuccessDeleteUser(this.message);
}

class FailureAdminState extends AdminState {
  final String message;

  const FailureAdminState(this.message);
}
