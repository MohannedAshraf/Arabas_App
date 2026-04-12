import 'package:arabas_app/core/services/local_storage_services.dart';
import 'package:arabas_app/features/profile/domain/usecases/profile_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase useCase;
  final LocalStorageService localStorage;

  ProfileCubit(this.useCase, this.localStorage) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());

    try {
      final profile = await useCase();
      emit(ProfileSuccess(profile));
    } catch (e) {
      final error = e.toString();

      // 🔥 session expired (no token or invalid token)
      if (error.contains("SESSION_EXPIRED") ||
          error.contains("انتهت صلاحية الجلسة") ||
          error.contains("401")) {
        await localStorage.clear();

        emit(
          ProfileSessionExpired(
            "انتهت صلاحية الجلسة، برجاء تسجيل الدخول مرة أخرى",
          ),
        );
        return;
      }

      // 🔥 server error
      if (error.contains("500")) {
        emit(ProfileError("حدث خطأ في السيرفر، حاول لاحقاً"));
        return;
      }

      // 🔥 fallback
      emit(ProfileError("تحقق من اتصال الانترنت"));
    }
  }
}
