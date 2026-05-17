import 'package:arabas_app/features/courses/domain/usecases/get_courses_sections_usecase.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_section_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final GetSectionsUseCase getSectionsUseCase;

  CoursesCubit(this.getSectionsUseCase) : super(CoursesInitial());

  Future<void> getSections() async {
    emit(CoursesLoading());

    try {
      final sections = await getSectionsUseCase();
      emit(CoursesSuccess(sections));
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }
}
