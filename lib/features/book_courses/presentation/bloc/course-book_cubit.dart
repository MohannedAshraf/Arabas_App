// ignore_for_file: file_names

import 'package:arabas_app/features/book_courses/domain/usecases/get_course_book_usecase.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/course_book_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBooksCubit extends Cubit<CourseBooksState> {
  final GetCourseBooksUseCase useCase;

  CourseBooksCubit(this.useCase) : super(CourseBooksInitial());

  Future<void> getCourseBooks() async {
    emit(CourseBooksLoading());

    try {
      final books = await useCase();
      emit(CourseBooksLoaded(books));
    } catch (e) {
      emit(CourseBooksError(e.toString()));
    }
  }
}
