import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/home/data/list_eo_model.dart';
import 'package:event_radar2/feature/home/repository/event_repository.dart';
import 'package:meta/meta.dart';

part 'creator_list_state.dart';

class CreatorListCubit extends Cubit<CreatorListState> {
  final EventRepository eventRepository;
  CreatorListCubit({required this.eventRepository})
      : super(CreatorListInitial());

  Future<void> getEventOrganizer() async {
    emit(CreatorListLoading());

    try {
      final result = await eventRepository.getEventOrganizer();

      emit(CreatorListLoaded(eoList: result));
    } catch (e) {
      emit(CreatorListFailed(error: e.toString()));
    }
  }
}
