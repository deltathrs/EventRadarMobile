import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/profile/repository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_avatar_state.dart';

class ProfileAvatarCubit extends Cubit<ProfileAvatarState> {
  final ProfileRepository profileRepository;
  ProfileAvatarCubit({required this.profileRepository})
      : super(ProfileAvatarInitial());

  Future<void> changeProfileAvatar(File avatar) async {
    emit(ChangeProfileAvatarLoading());

    try {
      final result = await profileRepository.postImageProfile(avatar);

      emit(ChangeProfileAvatarSuccess(message: result));
    } catch (e) {
      emit(ChangeProfileAvatarFailed(error: e.toString()));
    }
  }
}
