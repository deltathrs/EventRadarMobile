part of 'handle_content_event_cubit.dart';

@immutable
sealed class HandleContentEventState {}

final class HandleContentEventInitial extends HandleContentEventState {}

final class HandleContentEventPageUpdated extends HandleContentEventState {
  final int pageIndex;

  HandleContentEventPageUpdated({required this.pageIndex});
}
