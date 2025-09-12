import 'package:fe/data/models/response/response_model.dart';
import 'package:fe/data/models/user/user.dart';
import 'package:fe/data/repositories/admin/admin_repository.dart';
import 'package:fe/presentation/blocs/admin/admin_event.dart';
import 'package:fe/presentation/blocs/admin/admin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;

  AdminBloc(this.adminRepository) : super(InitialAdminState()) {
    on<FetchUsers>((event, emit) async {
      emit(LoadingAdminState());
      final response = await adminRepository.fetchUsers();
      if (response is SuccessResponse<List<User>>) {
        emit(LoadedUsers(response.message, response.data));
      } else if (response is ErrorResponse) {
        emit(FailureAdminState(response.message));
      }
    });

    on<DeleteUser>((event, emit) async {
      final response = await adminRepository.deleteUsers(event.id);
      if (response is SuccessResponse) {
        emit(SuccessDeleteUser(response.message));
        add(FetchUsers());
      } else if (response is ErrorResponse) {
        emit(FailureAdminState(response.message));
      }
    });
  }
}
