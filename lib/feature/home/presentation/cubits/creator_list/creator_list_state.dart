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
