import 'package:fe/data/models/response/auth_response.dart';
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
        final data = response.data;
        emit(AuthSuccess(response.message, data));
      } else if (response is ErrorResponse) {
        emit(AuthFailure(response.message, errors: response.errors));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await repository.register(event.registerRequest);
      if (response is SuccessResponse) {
        final data = response.data;
        emit(AuthSuccess(response.message, data));
      } else if (response is ErrorResponse) {
        emit(AuthFailure(response.message, errors: response.errors));
      }
    });
  }
}
