import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/manage_event/data/my_event_model.dart';
import 'package:event_radar2/feature/manage_event/repository/manage_event_repository.dart';
import 'package:meta/meta.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final ManageEventRepository manageEventRepository;
  EventCubit({required this.manageEventRepository}) : super(EventInitial());

  Future<void> getMyEvents() async {
    emit(MyEventLoading());
    try {
      final result = await manageEventRepository.getMyEvent();

      emit(MyEventLoaded(myEvents: result));
    } catch (e) {
      emit(MyEventFailed(error: e.toString()));
    }
  }
}
