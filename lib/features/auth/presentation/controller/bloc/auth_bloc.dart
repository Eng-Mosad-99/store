import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:store_app/core/api/api.dart';
import 'package:store_app/core/helper/bloc_manager.dart';
import 'package:store_app/core/service/service_locator.dart';
import 'package:store_app/features/auth/data/inputs/login_inputs.dart';
import 'package:store_app/features/auth/data/inputs/register_inputs.dart';
import 'package:store_app/features/auth/data/models/auth_model.dart';
import 'package:store_app/features/auth/data/repo/auth_repo.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ForgetPasswordEvent>(_onForgetPassword);
    on<VerifyResetCodeEvent>(_onVerifyResetCode);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepo.signIn(event.loginInputs);
    result.fold(
      (error) => emit(AuthError(error.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepo.signUp(event.registerInputs);
    result.fold(
      (error) => emit(AuthError(error.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onForgetPassword(
      ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(ForgetPasswordLoading());

    final result = await authRepo.forgetPassword(event.email);

    result.fold(
      (error) => emit(ForgetPasswordError(error: error)),
      (message) => emit(ForgetPasswordSuccess(message)),
    );
  }

  Future<void> _onVerifyResetCode(
      VerifyResetCodeEvent event, Emitter<AuthState> emit) async {
    emit(VerifyCodeLoading());

    final result = await authRepo.verifyResetCode(event.resetCode);

    result.fold(
      (error) => emit(VerifyCodeError(error: error)),
      (message) => emit(VerifyCodeSuccess(message)),
    );
  }

  Future<void> _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await authRepo.resetPassword(event.email, event.newPassword);

    result.fold(
      (errorMessage) => emit(AuthError(errorMessage)),
      (token) => emit(ResetPasswordSuccess(token)),
    );
  }
}

SingleChildWidget initAuthBloc({Widget? child}) {
  return GlobalBlocProvider(
    create: () => serviceLocator<AuthBloc>(),
    child: child,
  );
}
