import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_practical_usecase.dart';
import 'practical_state.dart';

class PracticalCubit extends Cubit<PracticalState> {
  final GetPracticalUseCase getPracticalUseCase;

  PracticalCubit(this.getPracticalUseCase) : super(PracticalInitial());

  Future<void> getPracticals() async {
    emit(PracticalLoading());

    try {
      final result = await getPracticalUseCase();

      emit(PracticalSuccess(result));
    } catch (e) {
      emit(PracticalError(e.toString()));
    }
  }
}
