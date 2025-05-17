part of 'save_profile_cubit.dart';

@immutable
sealed class SaveProfileState {}

final class SaveProfileInitial extends SaveProfileState {}

final class SaveProfileLoading extends SaveProfileState {}

final class SaveProfileSuccess extends SaveProfileState {
  final String message;

  SaveProfileSuccess({required this.message});
}

final class SaveProfileFailed extends SaveProfileState {
  final String error;

  SaveProfileFailed({required this.error});
}

final class LogoutLoading extends SaveProfileState {}

final class LogoutSuccess extends SaveProfileState {
  final String message;

  LogoutSuccess({required this.message});
}

final class LogoutFailed extends SaveProfileState {
  final String error;

  LogoutFailed({required this.error});
}
