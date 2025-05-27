part of 'event_transaction_cubit.dart';

@immutable
sealed class EventTransactionState {}

final class EventTransactionInitial extends EventTransactionState {}

final class EventTransactionLoading extends EventTransactionState {}

final class EventTransactionLoaded extends EventTransactionState {
  final String message;

  EventTransactionLoaded({required this.message});
}

final class EventTransactionFailed extends EventTransactionState {
  final String error;

  EventTransactionFailed({required this.error});
}
