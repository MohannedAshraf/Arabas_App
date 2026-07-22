import 'package:arabas_app/features/my_diploma/domain/usecases/get_my_diploma_details_usecase.dart';
import 'package:arabas_app/features/my_diploma/presentation/bloc/my_diploma_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDiplomaDetailsCubit extends Cubit<MyDiplomaDetailsState> {
  final GetMyDiplomaDetailsUseCase getMyDiplomaDetailsUseCase;

  MyDiplomaDetailsCubit({required this.getMyDiplomaDetailsUseCase})
    : super(const MyDiplomaDetailsInitial());

  Future<void> getMyDiplomaDetails({required String diplomaId}) async {
    emit(const MyDiplomaDetailsLoading());

    try {
      final diploma = await getMyDiplomaDetailsUseCase(diplomaId: diplomaId);

      emit(MyDiplomaDetailsSuccess(diploma));
    } catch (e) {
      emit(MyDiplomaDetailsError(e.toString()));
    }
  }
}
