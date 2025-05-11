part of 'profile_avatar_cubit.dart';

@immutable
sealed class ProfileAvatarState {}

final class ProfileAvatarInitial extends ProfileAvatarState {}

final class ChangeProfileAvatarLoading extends ProfileAvatarState {}

final class ChangeProfileAvatarSuccess extends ProfileAvatarState {
  final String message;

  ChangeProfileAvatarSuccess({required this.message});
}

final class ChangeProfileAvatarFailed extends ProfileAvatarState {
  final String error;

  ChangeProfileAvatarFailed({required this.error});
}
