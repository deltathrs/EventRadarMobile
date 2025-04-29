import 'package:bloc/bloc.dart';
import 'package:event_radar2/feature/authentication/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final message = await authRepository.apiLogin(email, password);
      emit(LoginSuccess(message));
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }

  Future<void> register(String email, String fullName, String password) async {
    emit(RegisterLoading());
    try {
      final message =
          await authRepository.apiRegister(email, fullName, password);
      emit(RegisterSuccess(message));
    } catch (e) {
      emit(RegisterFailed(e.toString()));
    }
  }
}
