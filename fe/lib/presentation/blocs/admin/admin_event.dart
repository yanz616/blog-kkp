abstract class AdminEvent {
  const AdminEvent();
}

class FetchUsers extends AdminEvent {
  const FetchUsers();
}

class DeleteUser extends AdminEvent {
  final int id;
  const DeleteUser(this.id);
}
