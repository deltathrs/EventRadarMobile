import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manage_event_state.dart';

class ManageEventCubit extends Cubit<ManageEventState> {
  ManageEventCubit() : super(ManageEventInitial());
}
