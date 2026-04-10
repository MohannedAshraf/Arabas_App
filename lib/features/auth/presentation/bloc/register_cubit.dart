import 'package:arabas_app/features/auth/data/models/register_model.dart';
import 'package:bloc/bloc.dart';

import '../../domain/usecases/register_usecase.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> register(RegisterRequestModel model) async {
    emit(RegisterLoading());

    try {
      final result = await registerUseCase(model);
      emit(RegisterSuccess(result.message));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
