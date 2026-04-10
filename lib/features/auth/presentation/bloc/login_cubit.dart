import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final SharedPreferences prefs;

  LoginCubit(this.loginUseCase, this.prefs) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
    required String deviceId,
  }) async {
    emit(LoginLoading());

    try {
      final result = await loginUseCase(
        email: email,
        password: password,
        deviceId: deviceId,
      );

      /// Save Token
      await prefs.setString("accessToken", result.accessToken);
      await prefs.setString("refreshToken", result.refreshToken);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
