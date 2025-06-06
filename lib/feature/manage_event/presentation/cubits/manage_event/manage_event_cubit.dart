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
    emit(ManageEventLoading());
    try {
      final categories = await manageEventRepository.getEventCategory();
      emit(ManageEventLoaded(categories: categories));
    } catch (e) {
      emit(ManageEventError(message: e.toString()));
    }
  }

  Future<void> changeEventStatus(String status, String id) async {
    emit(SaveEventLoading());
    try {
      final message = await manageEventRepository.changeEventStatus(status, id);
      emit(SaveEventSuccess(message: message));
    } catch (e) {
      emit(SaveEventError(error: e.toString()));
    }
  }

  Future<void> editEvent(EventDetailInputModel eventDetail, String id,
      {ContentVisualInputModel? content,
      List<TicketInputModel>? tickets,
      String? status}) async {
    try {
      emit(SaveEventLoading());
      final message = await manageEventRepository.editEvent(eventDetail, id,
          content: content, tickets: tickets, status: status);
      emit(SaveEventSuccess(message: message));
    } catch (e) {
      emit(SaveEventError(error: e.toString()));
    }
  }

  Future<void> createEvent(EventDetailInputModel eventDetail,
      {ContentVisualInputModel? content,
      List<TicketInputModel>? tickets,
      String? status}) async {
    try {
      emit(SaveEventLoading());
      final message = await manageEventRepository.createEvent(eventDetail,
          content: content, tickets: tickets, status: status);
      emit(SaveEventSuccess(message: message));
    } catch (e) {
      emit(SaveEventError(error: e.toString()));
    }
  }
}
