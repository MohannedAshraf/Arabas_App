import 'package:arabas_app/features/practicals/domain/usecases/get_practical_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'practical_details_state.dart';

class PracticalDetailsCubit extends Cubit<PracticalDetailsState> {
  final GetPracticalDetailsUseCase useCase;

  PracticalDetailsCubit(this.useCase) : super(PracticalDetailsInitial());

  Future<void> getDetails(String id) async {
    emit(PracticalDetailsLoading());

    try {
      final result = await useCase(id);

      emit(PracticalDetailsSuccess(result));
    } catch (e) {
      emit(PracticalDetailsError(e.toString()));
    }
  }
}
