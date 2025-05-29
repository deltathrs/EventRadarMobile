import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/home/repository/event_repository.dart';
import 'package:meta/meta.dart';

part 'event_transaction_state.dart';

class EventTransactionCubit extends Cubit<EventTransactionState> {
  final EventRepository eventRepository;
  EventTransactionCubit({required this.eventRepository})
      : super(EventTransactionInitial());

  Future<void> buyEvent(String ticketId) async {
    emit(EventTransactionLoading(ticketId: ticketId));
    try {
      final String message = await eventRepository.buyEvent(ticketId);
      emit(EventTransactionLoaded(message: message));
    } catch (e) {
      emit(EventTransactionFailed(error: e.toString()));
    }
  }
}
