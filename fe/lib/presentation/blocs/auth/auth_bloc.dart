import 'package:fe/core/utils/local_storage.dart';
import 'package:fe/data/models/response/response_model.dart';
import 'package:fe/data/models/user/user.dart';
import 'package:fe/data/repositories/auth_repository.dart';
import 'package:fe/presentation/blocs/auth/auth_event.dart';
import 'package:fe/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await repository.login(event.loginRequest);
      if (response is SuccessResponse) {
        final User data = response.data;
        await LocalStorage.setString(data.token);
        emit(AuthSuccess(response.message, data));
      } else if (response is ErrorResponse) {
        emit(AuthFailure(response.message));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await repository.register(event.registerRequest);
      if (response is SuccessResponse) {
        final data = response.data;
        emit(AuthSuccess(response.message, data));
      } else if (response is ErrorResponse) {
        emit(AuthFailure(response.message));
      }
    });
  }
}
