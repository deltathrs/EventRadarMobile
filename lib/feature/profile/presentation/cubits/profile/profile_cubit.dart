import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/home/data/list_eo_model.dart';
import 'package:event_radar2/feature/home/repository/event_repository.dart';
import 'package:event_radar2/feature/profile/data/balance_model.dart';
import 'package:event_radar2/feature/profile/data/profile_model.dart';
import 'package:event_radar2/feature/profile/data/ticket_detail_model.dart';
import 'package:event_radar2/feature/profile/repository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  final EventRepository eventRepository;
  ProfileCubit({
    required this.profileRepository,
    required this.eventRepository,
  }) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await profileRepository.getProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }



  Future<void> getTicketList({String? status}) async {
    emit(TicketListLoading());

    try {
      final result =
          await eventRepository.getTicketDetailList(status: status ?? "");
      final eoResult = await eventRepository.getEventOrganizer();

      emit(TicketListLoaded(tickets: result, eoModel: eoResult));
    } catch (e) {
      emit(TicketListFailed(message: e.toString()));
    }
  }

  Future<void> getEoData(String eoId) async {
    emit(EoDataLoading());

    try {
      final eoModel = await eventRepository.getEventOrganizer(id: eoId);
      emit(EoDataLoaded(eoModel: eoModel[0]));
    } catch (e) {
      emit(EoDataFailed(message: e.toString()));
    }
  }
}
