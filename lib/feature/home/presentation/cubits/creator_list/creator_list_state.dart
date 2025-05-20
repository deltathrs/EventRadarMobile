part of 'creator_list_cubit.dart';

@immutable
sealed class CreatorListState {}

final class CreatorListInitial extends CreatorListState {}

final class CreatorListLoading extends CreatorListState {}

final class CreatorListLoaded extends CreatorListState {
  final List<ListEoModel> eoList;

  CreatorListLoaded({required this.eoList});
}

final class CreatorListFailed extends CreatorListState {
  final String error;

  CreatorListFailed({required this.error});
}

final class EoEventLoading extends CreatorListState {}

final class EoEventLoaded extends CreatorListState {
  final List<EoEventModel> events;

  EoEventLoaded({required this.events});
}

final class EoEventFailed extends CreatorListState {
  final String error;

  EoEventFailed({required this.error});
}
