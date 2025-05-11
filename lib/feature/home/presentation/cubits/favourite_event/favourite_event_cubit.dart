import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/home/data/event_model.dart';
import 'package:event_radar2/feature/home/repository/event_repository.dart';
import 'package:meta/meta.dart';

part 'favourite_event_state.dart';

class FavouriteEventCubit extends Cubit<FavouriteEventState> {
  final EventRepository eventRepository;
  FavouriteEventCubit({required this.eventRepository})
      : super(FavouriteEventInitial());

  Future<void> addToFavourite(String eventId) async {
    emit(AddToFavouriteLoading());

    try {
      final result = await eventRepository.addEventToFavourite(eventId);

      emit(AddToFavouriteSuccess(message: result));
    } catch (e) {
      emit(AddToFavouriteFailed(error: e.toString()));
    }
  }

  Future<void> getFavouriteEvent() async {
    emit(FavouriteEventLoading());

    try {
      final result = await eventRepository.getFavouriteEventList();

      emit(FavouriteEventLoaded(favouriteList: result));
    } catch (e) {
      emit(FavouriteEventFailed(error: e.toString()));
    }
  }
}
