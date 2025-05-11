part of 'favourite_event_cubit.dart';

@immutable
sealed class FavouriteEventState {}

final class FavouriteEventInitial extends FavouriteEventState {}

final class FavouriteEventLoading extends FavouriteEventState {}

final class FavouriteEventLoaded extends FavouriteEventState {
  final List<EventModel> favouriteList;

  FavouriteEventLoaded({required this.favouriteList});
}

final class FavouriteEventFailed extends FavouriteEventState {
  final String error;

  FavouriteEventFailed({required this.error});
}

final class AddToFavouriteLoading extends FavouriteEventState {}

final class AddToFavouriteSuccess extends FavouriteEventState {
  final String message;

  AddToFavouriteSuccess({required this.message});
}

final class AddToFavouriteFailed extends FavouriteEventState {
  final String error;

  AddToFavouriteFailed({required this.error});
}
