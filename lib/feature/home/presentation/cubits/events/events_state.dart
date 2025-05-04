part of 'events_cubit.dart';

@immutable
sealed class EventsState {}

final class EventsInitial extends EventsState {}

final class EventListLoading extends EventsState {}

final class EventListLoaded extends EventsState {
  final List<EventModel> events;

  EventListLoaded({required this.events});
}

final class EventListFailed extends EventsState {
  final String message;

  EventListFailed({required this.message});
}

final class EventDetailLoading extends EventsState {}

final class EventDetailLoaded extends EventsState {
  final EventDetailModel eventDetail;

  EventDetailLoaded({required this.eventDetail});
}

final class EventDetailFailed extends EventsState {
  final String message;

  EventDetailFailed({required this.message});
}
