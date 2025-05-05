import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/home/data/event_detail_model.dart';
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
      final EventDetailModel eventDetail =
          await eventRepository.getEventDetail(id);
      emit(EventDetailLoaded(eventDetail: eventDetail));
    } catch (e) {
      emit(EventDetailFailed(message: e.toString()));
    }
  }

  Future<void> buyEvent(String ticketId) async {
    emit(EventDetailBuyLoading());
    try {
      final String message = await eventRepository.buyEvent(ticketId);
      emit(EventDetailBuySuccess(message: message));
    } catch (e) {
      emit(EventDetailBuyFailed(message: e.toString()));
    }
  }
}
