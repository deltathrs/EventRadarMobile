import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/home/data/event_model.dart';
import 'package:event_radar2/feature/home/repository/event_repository.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final EventRepository eventRepository;
  EventsCubit({required this.eventRepository}) : super(EventsInitial());

  Future<void> getEventList() async {
    emit(EventListLoading());
    try {
      final result = await eventRepository.getEventList();

      emit(EventListLoaded(events: result));
    } catch (e) {
      emit(EventListFailed(message: e.toString()));
    }
  }
}
