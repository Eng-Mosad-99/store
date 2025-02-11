part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class LoginEvent extends AuthEvent {
  final LoginInputs loginInputs;
  const LoginEvent({required this.loginInputs});

  @override
  List<Object> get props => [loginInputs];
}

final class RegisterEvent extends AuthEvent {
  final RegisterInputs registerInputs;
  const RegisterEvent({required this.registerInputs});

  @override
  List<Object> get props => [registerInputs];
}

final class ForgetPasswordEvent extends AuthEvent {
  final String email;
  const ForgetPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

final class VerifyResetCodeEvent extends AuthEvent {
  final String resetCode;
  const VerifyResetCodeEvent({required this.resetCode});

  @override
  List<Object> get props => [resetCode];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String newPassword;

  const ResetPasswordEvent({required this.email, required this.newPassword});

  @override
  List<Object> get props => [email, newPassword];
}
