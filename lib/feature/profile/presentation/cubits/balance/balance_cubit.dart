import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/profile/data/balance_model.dart';
import 'package:event_radar2/feature/profile/repository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final ProfileRepository profileRepository;
  BalanceCubit({required this.profileRepository}) : super(BalanceInitial());

  Future<void> getBalance() async {
    emit(BalanceLoading());

    try {
      final balance = await profileRepository.getBalance();
      emit(BalanceLoaded(balance: balance));
    } catch (e) {
      emit(BalanceFailed(message: e.toString()));
    }
  }
}
