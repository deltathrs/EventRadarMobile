import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/profile/repository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'save_profile_state.dart';

class SaveProfileCubit extends Cubit<SaveProfileState> {
  final ProfileRepository profileRepository;
  SaveProfileCubit({required this.profileRepository})
      : super(SaveProfileInitial());

  Future<void> saveProfile(
      String fullName, String phoneNumber, String domicile) async {
    emit(SaveProfileLoading());

    try {
      final result =
          await profileRepository.editProfile(fullName, domicile, phoneNumber);

      emit(SaveProfileSuccess(message: result));
    } catch (e) {
      emit(SaveProfileFailed(error: e.toString()));
    }
  }
}
