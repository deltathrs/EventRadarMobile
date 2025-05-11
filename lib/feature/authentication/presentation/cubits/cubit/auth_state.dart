part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final String message;

  LoginSuccess(this.message);
}

final class LoginFailed extends AuthState {
  final String error;

  LoginFailed(this.error);
}

final class GoogleLoginLoading extends AuthState {}

final class GoogleLoginSuccess extends AuthState {
  final String message;

  GoogleLoginSuccess(this.message);
}

final class GoogleLoginFailed extends AuthState {
  final String error;

  GoogleLoginFailed(this.error);
}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {
  final String message;

  RegisterSuccess(this.message);
}

final class RegisterFailed extends AuthState {
  final String error;

  RegisterFailed(this.error);
}
