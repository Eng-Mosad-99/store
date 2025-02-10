import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_app/core/helper/bloc_manager.dart';
import 'package:store_app/core/service/service_locator.dart';
import 'package:store_app/features/auth/data/inputs/login_inputs.dart';
import 'package:store_app/features/auth/data/models/auth_model.dart';
import 'package:store_app/features/auth/data/repo/auth_repo.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(AuthLoading());
        final result = await authRepo.signIn(event.loginInputs);
        result.fold(
          (error) => emit(AuthError(error.message)),
          (user) => emit(AuthSuccess(user)),
        );
      }
    });
  }
}

SingleChildWidget initAuthBloc({Widget? child}) {
  return GlobalBlocProvider(
    create: () => serviceLocator<AuthBloc>(),
    child: child,
  );
}
