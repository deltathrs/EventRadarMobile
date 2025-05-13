part of 'event_cubit.dart';

@immutable
sealed class EventState {}

final class EventInitial extends EventState {}

final class MyEventLoading extends EventState {}

final class MyEventLoaded extends EventState {
  final List<MyEventModel> myEvents;

  MyEventLoaded({required this.myEvents});
}

final class MyEventFailed extends EventState {
  final String error;

  MyEventFailed({required this.error});
}
