part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

final class ForgetPasswordSuccess extends AuthState {
  final String message;
  const ForgetPasswordSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class ForgetPasswordLoading extends AuthState {}

final class ForgetPasswordError extends AuthState {
  final String error;

  const ForgetPasswordError({required this.error});

  @override
  List<Object> get props => [error];
}

final class VerifyCodeSuccess extends AuthState {
  final String message;
  const VerifyCodeSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class VerifyCodeLoading extends AuthState {}

final class VerifyCodeError extends AuthState {
  final String error;

  const VerifyCodeError({required this.error});

  @override
  List<Object> get props => [error];
}

class ResetPasswordSuccess extends AuthState {
  final String token;
  const ResetPasswordSuccess(this.token);

  @override
  List<Object> get props => [token];
}
