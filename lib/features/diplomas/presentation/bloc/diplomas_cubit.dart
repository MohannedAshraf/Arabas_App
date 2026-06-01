import 'package:arabas_app/features/diplomas/domain/usecases/diplomas_usecase.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diplomas_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiplomaCubit extends Cubit<DiplomaState> {
  final GetDiplomasUseCase getDiplomasUseCase;

  DiplomaCubit(this.getDiplomasUseCase) : super(DiplomaInitial());

  Future<void> getDiplomas() async {
    emit(DiplomaLoading());

    try {
      final result = await getDiplomasUseCase();

      emit(DiplomaLoaded(result));
    } catch (e) {
      emit(DiplomaError(e.toString()));
    }
  }
}
