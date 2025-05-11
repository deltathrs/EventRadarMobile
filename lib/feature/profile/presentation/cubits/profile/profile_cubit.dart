import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/home/repository/event_repository.dart';
import 'package:event_radar2/feature/profile/data/profile_model.dart';
import 'package:event_radar2/feature/profile/data/ticket_detail_model.dart';
import 'package:event_radar2/feature/profile/repository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  final EventRepository eventRepository;
  ProfileCubit({required this.profileRepository, required this.eventRepository})
      : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await profileRepository.getProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> getTicketList() async {
    emit(TicketListLoading());

    try {
      final result = await eventRepository.getTicketDetailList();

      emit(TicketListLoaded(tickets: result));
    } catch (e) {
      emit(TicketListFailed(message: e.toString()));
    }
  }
}
