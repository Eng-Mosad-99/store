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
