import 'package:arabas_app/features/my_diploma/domain/usecases/get_my_diploma_usecase.dart';
import 'package:arabas_app/features/my_diploma/presentation/bloc/my_diploma_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDiplomaCubit extends Cubit<MyDiplomaState> {
  final GetMyDiplomasUseCase getMyDiplomasUseCase;

  MyDiplomaCubit({required this.getMyDiplomasUseCase})
    : super(const MyDiplomaInitial());

  Future<void> getMyDiplomas() async {
    emit(const MyDiplomaLoading());

    try {
      final diplomas = await getMyDiplomasUseCase(activeOnly: true);

      emit(MyDiplomaSuccess(diplomas));
    } catch (e) {
      emit(MyDiplomaError(e.toString()));
    }
  }
}
