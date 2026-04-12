// ignore_for_file: avoid_print

import 'package:arabas_app/features/auth/data/models/login_model.dart';
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
    required String platform,
  }) async {
    emit(LoginLoading());

    try {
      final request = LoginRequestModel(
        email: email,
        password: password,
        deviceId: deviceId,
        fingerprint: "",
        platform: platform,
      );

      final result = await loginUseCase(request);

      await prefs.setString("accessToken", result.accessToken);
      await prefs.setString("refreshToken", result.refreshToken);
      print("Access Token: ${result.accessToken}");
      print("Refresh Token: ${result.refreshToken}");

      emit(LoginSuccess());
    } catch (e) {
      final message = e.toString().replaceAll("Exception: ", "");
      emit(LoginFailure(message));
    }
  }
}
