part of 'atendees_cubit.dart';

@immutable
sealed class AtendeesState {}

final class AtendeesInitial extends AtendeesState {}

final class AtendeesLoading extends AtendeesState {}

final class AtendeesLoaded extends AtendeesState {
  final List<AtendeesModel> atendees;

  AtendeesLoaded({required this.atendees});
}

final class AtendeesError extends AtendeesState {
  final String message;

  AtendeesError({required this.message});
}
