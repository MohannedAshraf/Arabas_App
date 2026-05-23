// my_courses_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_my_courses_usecase.dart';
import 'my_courses_state.dart';

class MyCoursesCubit extends Cubit<MyCoursesState> {
  final GetMyCoursesUseCase getMyCoursesUseCase;

  MyCoursesCubit(this.getMyCoursesUseCase) : super(MyCoursesInitial());

  Future<void> getMyCourses() async {
    emit(MyCoursesLoading());

    try {
      final result = await getMyCoursesUseCase();

      emit(MyCoursesLoaded(result));
    } catch (e) {
      emit(MyCoursesError(e.toString()));
    }
  }
}
