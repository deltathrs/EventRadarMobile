import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/manage_event/data/atendees_model.dart';
import 'package:event_radar2/feature/manage_event/repository/manage_event_repository.dart';
import 'package:meta/meta.dart';

part 'atendees_state.dart';

class AtendeesCubit extends Cubit<AtendeesState> {
  final ManageEventRepository manageEventRepository;
  AtendeesCubit({required this.manageEventRepository})
      : super(AtendeesInitial());

  Future<void> getAtendeesList(String eventId) async {
    emit(AtendeesLoading());
    try {
      final atendees = await manageEventRepository.getAtendeesList(eventId);

      emit(AtendeesLoaded(atendees: atendees));
    } catch (e) {
      emit(AtendeesError(message: e.toString()));
    }
  }
}
