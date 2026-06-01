import 'package:arabas_app/core/network/dio_helper.dart';
import 'package:arabas_app/core/services/auth_refresh_services.dart';
import 'package:arabas_app/core/services/local_storage_services.dart';
import 'package:arabas_app/core/services/register_api_service.dart';
import 'package:arabas_app/features/book_courses/data/data_source/course_book_details_remote_data_source.dart';
import 'package:arabas_app/features/book_courses/data/data_source/course_book_remote_data_source.dart';
import 'package:arabas_app/features/book_courses/data/data_source/verify_book_remote_data_source.dart';
import 'package:arabas_app/features/book_courses/domain/repo/course_book_details_repo.dart';
import 'package:arabas_app/features/book_courses/domain/repo/course_book_details_repo_impl.dart';
import 'package:arabas_app/features/book_courses/domain/repo/course_book_repo.dart';
import 'package:arabas_app/features/book_courses/domain/repo/course_book_repo_impl.dart';
import 'package:arabas_app/features/book_courses/domain/repo/verify_book_repo.dart';
import 'package:arabas_app/features/book_courses/domain/repo/verify_book_repo_impl.dart';
import 'package:arabas_app/features/book_courses/domain/usecases/get_course_book_details_usecase.dart';
import 'package:arabas_app/features/book_courses/domain/usecases/get_course_book_usecase.dart';
import 'package:arabas_app/features/book_courses/domain/usecases/verify_book_usecase.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/course-book_cubit.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/course_book_details_cubit.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/verify_book_cubit.dart';
import 'package:arabas_app/features/certificates/data/data%20sources/build_certificate_remote_data_source.dart';
import 'package:arabas_app/features/certificates/data/data%20sources/my_certificates_remote_data_source.dart';
import 'package:arabas_app/features/certificates/domain/repo/build_certificate_repo.dart';
import 'package:arabas_app/features/certificates/domain/repo/build_certificate_repo_impl.dart';
import 'package:arabas_app/features/certificates/domain/repo/my_certificates_repo.dart';
import 'package:arabas_app/features/certificates/domain/repo/my_certificates_repo_impl.dart';
import 'package:arabas_app/features/certificates/domain/usecases/build_certificate_usecase.dart';
import 'package:arabas_app/features/certificates/domain/usecases/get_my_certificates_usecase.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/build_certificate_cubit.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/my_certificates_cubit.dart';
import 'package:arabas_app/features/courses/data/data_sources/course_details_remote_data_source.dart';
import 'package:arabas_app/features/courses/data/data_sources/courses_in_section_remote_data_source.dart';
import 'package:arabas_app/features/courses/data/data_sources/courses_remote_data_source.dart';
import 'package:arabas_app/features/courses/domain/repo/course_details_repo.dart';
import 'package:arabas_app/features/courses/domain/repo/course_details_repo_impl.dart';
import 'package:arabas_app/features/courses/domain/repo/courses_in_section_repo.dart';
import 'package:arabas_app/features/courses/domain/repo/courses_in_section_repo_impl.dart';
import 'package:arabas_app/features/courses/domain/repo/courses_section_repo.dart';
import 'package:arabas_app/features/courses/domain/repo/courses_section_repo_impl.dart';
import 'package:arabas_app/features/courses/domain/usecases/get_course_details_usecase.dart';
import 'package:arabas_app/features/courses/domain/usecases/get_courses_in_section_usecase.dart';
import 'package:arabas_app/features/courses/domain/usecases/get_courses_sections_usecase.dart';
import 'package:arabas_app/features/courses/presentation/bloc/course_details_cubit.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_in-section-cubit.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_sections_cubit.dart';
import 'package:arabas_app/features/diplomas/data/data_sources/diploma_details_remote_data_source.dart';
import 'package:arabas_app/features/diplomas/data/data_sources/diplomas_remote_data_source.dart';
import 'package:arabas_app/features/diplomas/domain/repo/diploma_details_repo.dart';
import 'package:arabas_app/features/diplomas/domain/repo/diploma_details_repo_impl.dart';
import 'package:arabas_app/features/diplomas/domain/repo/diplomas_repo.dart';
import 'package:arabas_app/features/diplomas/domain/repo/diplomas_repo_impl.dart';
import 'package:arabas_app/features/diplomas/domain/usecases/diplomas_usecase.dart';
import 'package:arabas_app/features/diplomas/domain/usecases/get_diploma_details_usecase.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diploma_details_cubit.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diplomas_cubit.dart';
import 'package:arabas_app/features/free_lectures/data/data_sources/article_details_remote_data_source.dart';
import 'package:arabas_app/features/free_lectures/data/data_sources/free_content_remote_data_source.dart';
import 'package:arabas_app/features/free_lectures/data/data_sources/video_details_data_source.dart';
import 'package:arabas_app/features/free_lectures/domain/repo/article_details_repo.dart';
import 'package:arabas_app/features/free_lectures/domain/repo/article_details_repo_impl.dart';
import 'package:arabas_app/features/free_lectures/domain/repo/free_content_repo.dart';
import 'package:arabas_app/features/free_lectures/domain/repo/free_content_repo_impl.dart';
import 'package:arabas_app/features/free_lectures/domain/repo/video_details_repo.dart';
import 'package:arabas_app/features/free_lectures/domain/repo/video_details_repo_impl.dart';
import 'package:arabas_app/features/free_lectures/domain/usecases/get_article_details_usecase.dart';
import 'package:arabas_app/features/free_lectures/domain/usecases/video_details_usecase.dart';
import 'package:arabas_app/features/free_lectures/presentation/bloc/article_details_cubit.dart';
import 'package:arabas_app/features/free_lectures/presentation/bloc/video_details_cubit.dart';
import 'package:arabas_app/features/my_courses/data/data_sources/my_course_details_remote_data_source.dart';
import 'package:arabas_app/features/my_courses/data/data_sources/my_courses_remote_data_source.dart';
import 'package:arabas_app/features/my_courses/data/data_sources/my_video_details_remote_data_source.dart';
import 'package:arabas_app/features/my_courses/data/data_sources/progress_remote_data_source.dart';
import 'package:arabas_app/features/my_courses/data/data_sources/progress_remote_data_source_impl.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_course_details_repo.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_course_details_repo_impl.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_courses_repo.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_courses_repo_impl.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_video_details_repo.dart';
import 'package:arabas_app/features/my_courses/domain/repo/my_video_details_repo_impl.dart';
import 'package:arabas_app/features/my_courses/domain/repo/progress_repo.dart';
import 'package:arabas_app/features/my_courses/domain/repo/progress_repo_impl.dart';
import 'package:arabas_app/features/my_courses/domain/usecases/get_my_course_details_usecase.dart';
import 'package:arabas_app/features/my_courses/domain/usecases/get_my_courses_usecase.dart';
import 'package:arabas_app/features/my_courses/domain/usecases/get_my_video_details_usecase.dart';
import 'package:arabas_app/features/my_courses/domain/usecases/track_progress_usecase.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_course_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_courses_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_video_details_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/progress_cubit.dart';
import 'package:arabas_app/features/question_bank/data/data_sources/bank_questions_remote_data_source.dart';
import 'package:arabas_app/features/question_bank/domain/repo/bank_questions_repo.dart';
import 'package:arabas_app/features/question_bank/domain/repo/bank_questions_repo_impl.dart';
import 'package:arabas_app/features/question_bank/domain/usecases/get_bank_questions_usecase.dart';
import 'package:arabas_app/features/question_bank/presentation/bloc/bank_questions_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 🔥 Auth Feature
import 'package:arabas_app/features/auth/data/data_sources/register_remote_data_source.dart';
import 'package:arabas_app/features/auth/data/data_sources/login_remote_data_source.dart';
import 'package:arabas_app/features/auth/domain/repo/register_repo.dart';
import 'package:arabas_app/features/auth/domain/repo/register_repo_impl.dart';
import 'package:arabas_app/features/auth/domain/repo/login_repo.dart';
import 'package:arabas_app/features/auth/domain/repo/login_repo_impl.dart';
import 'package:arabas_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:arabas_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:arabas_app/features/auth/presentation/bloc/register_cubit.dart';
import 'package:arabas_app/features/auth/presentation/bloc/login_cubit.dart';

/// 🔥 Profile Feature
import 'package:arabas_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:arabas_app/features/profile/domain/repo/profile_repo.dart';
import 'package:arabas_app/features/profile/domain/repo/profile_repo_impl.dart';
import 'package:arabas_app/features/profile/domain/usecases/profile_usecases.dart';
import 'package:arabas_app/features/profile/presentation/bloc/profile_cubit.dart';

/// 🔥 Free Content Feature

import 'package:arabas_app/features/free_lectures/domain/usecases/get_articles_usecase.dart';
import 'package:arabas_app/features/free_lectures/domain/usecases/get_videos_usecase.dart';
import 'package:arabas_app/features/free_lectures/presentation/bloc/free_content_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ======================
  // 🔥 External Services
  // ======================

  /// ⭐ Dio Helper (بدل Dio عادي)
  sl.registerLazySingleton<Dio>(() => DioHelper.createDio());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(sl()),
  );
  sl.registerLazySingleton<AuthRefreshService>(
    () => AuthRefreshService(sl<LocalStorageService>()),
  );

  // ======================
  // 🔥 API Services
  // ======================

  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl()));

  // ======================
  // 🔥 Auth Data Sources
  // ======================

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(sl()),
  );

  // ======================
  // 🔥 Profile Data Source
  // ======================

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  // ======================
  // 🔥 Free Content Data Source
  // ======================

  sl.registerLazySingleton<FreeContentRemoteDataSource>(
    () => FreeContentRemoteDataSourceImpl(sl()),
  );

  // ======================
  // 🔥 Repositories
  // ======================

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl()),
  );

  /// ⭐ Free Content Repo
  sl.registerLazySingleton<FreeContentRepo>(() => FreeContentRepoImpl(sl()));

  // ======================
  // 🔥 UseCases
  // ======================

  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<ProfileUseCase>(() => ProfileUseCase(sl()));

  /// ⭐ Free Content UseCases
  sl.registerLazySingleton(() => GetArticlesUseCase(sl()));
  sl.registerLazySingleton(() => GetVideosUseCase(sl()));

  // ======================
  // 🔥 Cubits
  // ======================

  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl()));
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl(), sl()));

  /// ⭐ Free Content Cubit
  sl.registerFactory(() => FreeContentCubit(sl(), sl()));

  /// Article Details Data Source
  sl.registerLazySingleton<ArticleDetailsRemoteDataSource>(
    () => ArticleDetailsRemoteDataSourceImpl(sl()),
  );

  /// Repo
  sl.registerLazySingleton<ArticleDetailsRepo>(
    () => ArticleDetailsRepoImpl(sl()),
  );

  /// UseCase
  sl.registerLazySingleton(() => GetArticleDetailsUseCase(sl()));

  /// Cubit
  sl.registerFactory(() => ArticleDetailsCubit(sl()));

  sl.registerLazySingleton<FreeVideoRemoteDataSource>(
    () => FreeVideoRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<FreeVideoRepository>(
    () => FreeVideoRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetVideoByIdUseCase(sl()));

  sl.registerFactory(() => VideoPlayerCubit(sl()));

  // COURSES FEATURE

  sl.registerLazySingleton<CoursesRemoteDataSource>(
    () => CoursesRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CoursesRepo>(() => CoursesRepoImpl(sl()));

  sl.registerLazySingleton(() => GetSectionsUseCase(sl()));

  sl.registerFactory(() => CoursesCubit(sl()));

  sl.registerLazySingleton<CoursesInSectionRemoteDataSource>(
    () => CoursesInSectionRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CoursessRepo>(() => CoursessRepoImpl(sl()));

  sl.registerLazySingleton(() => GetCoursesUseCase(sl()));
  sl.registerFactory(() => CoursesBySectionCubit(sl()));

  // ======================
  // 🔥 Course Details Feature
  // ======================

  sl.registerLazySingleton<CourseDetailsRemoteDataSource>(
    () => CourseDetailsRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CourseDetailsRepository>(
    () => CourseDetailsRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetCourseDetailsUseCase(sl()));

  sl.registerFactory(() => CourseDetailsCubit(sl()));

  // ======================
  // 🔥 Course Books Feature
  // ======================

  sl.registerLazySingleton<CourseBooksRemoteDataSource>(
    () => CourseBooksRemoteDataSourceImpl(sl(), sl()),
  );

  sl.registerLazySingleton<CourseBooksRepo>(() => CourseBooksRepoImpl(sl()));

  sl.registerLazySingleton(() => GetCourseBooksUseCase(sl()));

  sl.registerFactory(() => CourseBooksCubit(sl()));

  // remote
  sl.registerLazySingleton(() => CourseBookDetailsRemoteDS());

  // repo
  sl.registerLazySingleton<CourseBookDetailsRepo>(
    () => CourseBookDetailsRepoImpl(sl()),
  );

  // usecase
  sl.registerLazySingleton(() => GetCourseBookDetailsUseCase(sl()));

  // cubit
  sl.registerFactory(() => CourseBookDetailsCubit(sl()));

  // ======================
  // 🔥 Verify Book Feature
  // ======================

  sl.registerLazySingleton<VerifyBookRemoteDataSource>(
    () => VerifyBookRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<VerifyBookRepo>(() => VerifyBookRepoImpl(sl()));

  sl.registerLazySingleton(() => VerifyBookUseCase(sl()));

  sl.registerFactory(() => VerifyBookCubit(sl()));

  // ======================
  // 🔥 My Courses Feature
  // ======================

  sl.registerLazySingleton<MyCoursesRemoteDataSource>(
    () => MyCoursesRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<MyCoursesRepo>(() => MyCoursesRepoImpl(sl()));

  sl.registerLazySingleton(() => GetMyCoursesUseCase(sl()));

  sl.registerFactory(() => MyCoursesCubit(sl()));

  // ======================
  // 🔥 Subscribed Course Details
  // ======================

  sl.registerLazySingleton<MyCourseDetailsRemoteDataSource>(
    () => MyCourseDetailsRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<MyCourseDetailsRepo>(
    () => MyCourseDetailsRepoImpl(sl()),
  );

  sl.registerLazySingleton(() => GetMyCourseDetailsUsecase(sl()));

  sl.registerFactory(() => MyCourseDetailsCubit(sl()));
  // ======================
  // 🔥 My Video Details Feature
  // ======================

  sl.registerLazySingleton<MyVideoDetailsRemoteDataSource>(
    () => MyVideoDetailsRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<MyVideoDetailsRepo>(
    () => MyVideoDetailsRepoImpl(sl()),
  );

  sl.registerLazySingleton(() => GetMyVideoDetailsUsecase(sl()));

  sl.registerFactory(() => MyVideoDetailsCubit(sl()));

  /// DATASOURCE
  sl.registerLazySingleton<ProgressRemoteDataSource>(
    () => ProgressRemoteDataSourceImpl(sl()),
  );

  /// REPOSITORY
  sl.registerLazySingleton<ProgressRepository>(
    () => ProgressRepositoryImpl(sl()),
  );

  /// USECASE
  sl.registerLazySingleton(() => TrackProgressUseCase(sl()));

  /// CUBIT
  sl.registerFactory(() => ProgressCubit(sl()));

  /// DATASOURCE
  sl.registerLazySingleton<BuildCertificateRemoteDataSource>(
    () => BuildCertificateRemoteDataSourceImpl(sl()),
  );

  /// REPOSITORY
  sl.registerLazySingleton<BuildCertificateRepository>(
    () => BuildCertificateRepositoryImpl(sl()),
  );

  /// USECASE
  sl.registerLazySingleton(() => BuildCertificateUseCase(sl()));

  /// CUBIT
  sl.registerFactory(() => BuildCertificateCubit(sl()));

  /// DATA SOURCE
  sl.registerLazySingleton<CertificateRemoteDataSource>(
    () => CertificateRemoteDataSourceImpl(sl()),
  );

  /// REPOSITORY
  sl.registerLazySingleton<CertificateRepository>(
    () => CertificateRepositoryImpl(sl()),
  );

  /// USE CASE
  sl.registerLazySingleton(() => GetMyCertificatesUseCase(sl()));

  /// CUBIT
  sl.registerFactory(() => CertificateCubit(sl()));

  /// DATA SOURCE
  sl.registerLazySingleton<DiplomaRemoteDataSource>(
    () => DiplomaRemoteDataSourceImpl(sl()),
  );

  /// REPOSITORY
  sl.registerLazySingleton<DiplomaRepository>(
    () => DiplomaRepositoryImpl(sl()),
  );

  /// USE CASE
  sl.registerLazySingleton(() => GetDiplomasUseCase(sl()));

  /// CUBIT
  sl.registerFactory(() => DiplomaCubit(sl()));

  /// DATA SOURCE
  sl.registerLazySingleton<DiplomaDetailsRemoteDataSource>(
    () => DiplomaDetailsRemoteDataSourceImpl(sl()),
  );

  /// REPOSITORY
  sl.registerLazySingleton<DiplomaDetailsRepository>(
    () => DiplomaDetailsRepositoryImpl(sl()),
  );

  /// USE CASE
  sl.registerLazySingleton(() => GetDiplomaDetailsUseCase(sl()));

  /// CUBIT
  sl.registerFactory(() => DiplomaDetailsCubit(sl()));

  /// DATA SOURCE
  sl.registerLazySingleton<BankQuestionsRemoteDataSource>(
    () => BankQuestionsRemoteDataSourceImpl(sl()),
  );

  /// REPOSITORY
  sl.registerLazySingleton<BankQuestionsRepository>(
    () => BankQuestionsRepositoryImpl(sl()),
  );

  /// USE CASE
  sl.registerLazySingleton(() => GetBankQuestionsUseCase(sl()));

  /// CUBIT
  sl.registerFactory(() => BankQuestionsCubit(sl()));
}
