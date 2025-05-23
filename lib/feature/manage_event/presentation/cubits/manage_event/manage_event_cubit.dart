import 'package:bloc/bloc.dart';
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
}
