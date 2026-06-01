import 'package:arabas_app/features/diplomas/domain/usecases/get_diploma_details_usecase.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diploma_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiplomaDetailsCubit extends Cubit<DiplomaDetailsState> {
  final GetDiplomaDetailsUseCase useCase;

  DiplomaDetailsCubit(this.useCase) : super(DiplomaDetailsInitial());

  Future<void> getDiplomaDetails(String id) async {
    emit(DiplomaDetailsLoading());

    try {
      final result = await useCase(id);

      emit(DiplomaDetailsLoaded(result));
    } catch (e) {
      emit(DiplomaDetailsError(e.toString()));
    }
  }
}
