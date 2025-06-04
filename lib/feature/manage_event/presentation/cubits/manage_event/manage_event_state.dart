part of 'manage_event_cubit.dart';

@immutable
sealed class ManageEventState {}

final class ManageEventInitial extends ManageEventState {}

final class ManageEventLoading extends ManageEventState {}

final class ManageEventLoaded extends ManageEventState {
  final List<String> categories;

  ManageEventLoaded({
    required this.categories,
  });
}

final class ManageEventError extends ManageEventState {
  final String message;

  ManageEventError({required this.message});
}

final class SaveEventLoading extends ManageEventState {}

final class SaveEventSuccess extends ManageEventState {
  final String message;

  SaveEventSuccess({required this.message});
}

final class SaveEventError extends ManageEventState {
  final String error;

  SaveEventError({required this.error});
}
