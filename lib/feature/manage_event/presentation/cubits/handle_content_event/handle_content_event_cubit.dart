import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'handle_content_event_state.dart';

class HandleContentEventCubit extends Cubit<HandleContentEventState> {
  HandleContentEventCubit() : super(HandleContentEventInitial());

  int get pageIndex {
    if (state is HandleContentEventPageUpdated) {
      return (state as HandleContentEventPageUpdated).pageIndex;
    }
    return 0;
  }

  void nextPage() {
    if (pageIndex < 3 - 1) {
      emit(HandleContentEventPageUpdated(pageIndex: pageIndex + 1));
    }
  }

  void previousPage() {
    if (pageIndex > 0) {
      emit(HandleContentEventPageUpdated(pageIndex: pageIndex - 1));
    }
  }

  Future<void> goToPage(int index) async {
    emit(HandleContentEventPageUpdated(pageIndex: index));
    return;
  }
}
