import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/manage_event/data/content_visual_input_model.dart';
import 'package:event_radar2/feature/manage_event/data/event_detail_input_model.dart';
import 'package:event_radar2/feature/manage_event/data/ticket_model.dart';
import 'package:event_radar2/feature/manage_event/repository/manage_event_repository.dart';
import 'package:meta/meta.dart';

part 'manage_event_state.dart';

class ManageEventCubit extends Cubit<ManageEventState> {
  final ManageEventRepository manageEventRepository;
  ManageEventCubit({required this.manageEventRepository})
      : super(ManageEventInitial());

  Future<void> getEventCategory() async {
    try {
      emit(ManageEventLoading());
      final categories = await manageEventRepository.getEventCategory();
      emit(ManageEventLoaded(categories: categories));
    } catch (e) {
      emit(ManageEventError(message: e.toString()));
    }
  }

  Future<void> createEvent(EventDetailInputModel eventDetail,
      ContentVisualInputModel content, List<TicketInputModel> tickets) async {
    try {
      emit(SaveEventLoading());
      final message = await manageEventRepository.createEvent(
          eventDetail, content, tickets);
      emit(SaveEventSuccess(message: message));
    } catch (e) {
      emit(SaveEventError(error: e.toString()));
    }
  }
}
