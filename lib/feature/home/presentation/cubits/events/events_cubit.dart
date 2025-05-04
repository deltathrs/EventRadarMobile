import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/home/data/event_detail_model.dart';
import 'package:event_radar2/feature/home/data/event_model.dart';
import 'package:event_radar2/feature/home/repository/event_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final EventRepository eventRepository;
  final PagingController<int, EventModel> pagingController =
      PagingController(firstPageKey: 0);
  String? name;
  List<String>? categories;
  bool? isOnline;
  EventsCubit({required this.eventRepository}) : super(EventsInitial()) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> getEventList() async {
    emit(EventListLoading());
    try {
      final result = await eventRepository.getEventList([], "", false, 1);

      emit(EventListLoaded(events: result));
    } catch (e) {
      emit(EventListFailed(message: e.toString()));
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    int page = pageKey ~/ 10;
    try {
      final newItems = await eventRepository.getEventList(
          categories ?? [], name ?? "", isOnline ?? false, page + 1);

      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void refresh() {
    pagingController.refresh();
  }

  void updateFilters({
    String? name,
    bool? isOnline,
    List<String>? categories,
  }) {
    this.name = name;
    this.isOnline = isOnline;
    this.categories = categories;

    pagingController.refresh();
  }
}
