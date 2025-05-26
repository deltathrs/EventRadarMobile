part of 'event_detail_cubit.dart';

@immutable
sealed class EventDetailState {}

final class EventDetailInitial extends EventDetailState {}

final class EventDetailLoading extends EventDetailState {}

final class EventDetailLoaded extends EventDetailState {
  final EventDetailModel eventDetail;
  final ListEoModel eventOrganizer;

  EventDetailLoaded({required this.eventDetail, required this.eventOrganizer});
}

final class EventDetailFailed extends EventDetailState {
  final String message;

  EventDetailFailed({required this.message});
}

final class EventDetailBuyLoading extends EventDetailState {}

final class EventDetailBuySuccess extends EventDetailState {
  final String message;

  EventDetailBuySuccess({required this.message});
}

final class EventDetailBuyFailed extends EventDetailState {
  final String message;

  EventDetailBuyFailed({required this.message});
}
