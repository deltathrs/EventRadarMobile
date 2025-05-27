import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/home/data/event_detail_model.dart';
import 'package:event_radar2/feature/home/data/list_eo_model.dart';
import 'package:event_radar2/feature/home/repository/event_repository.dart';
import 'package:meta/meta.dart';

part 'event_detail_state.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  final EventRepository eventRepository;
  EventDetailCubit({required this.eventRepository})
      : super(EventDetailInitial());

  Future<void> getEventDetail(String id) async {
    emit(EventDetailLoading());
    try {
      final eventDetail = await eventRepository.getEventDetail(id);
      final eventOrganizer =
          await eventRepository.getEventOrganizer(id: eventDetail.organizerId);
      emit(EventDetailLoaded(
          eventDetail: eventDetail, eventOrganizer: eventOrganizer[0]));
    } catch (e) {
      emit(EventDetailFailed(message: e.toString()));
    }
  }

  
}
