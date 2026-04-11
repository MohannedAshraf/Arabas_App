import 'package:arabas_app/features/profile/domain/usecases/profile_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase useCase;

  ProfileCubit(this.useCase) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());

    try {
      final profile = await useCase();
      emit(ProfileSuccess(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
