import 'package:arabas_app/core/services/local_storage_services.dart';
import 'package:arabas_app/core/services/register_api_service.dart';
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

final sl = GetIt.instance;

Future<void> init() async {
  // ======================
  // 🔥 External Services
  // ======================

  sl.registerLazySingleton<Dio>(() => Dio());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  /// ✅ Local Storage Service
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(sl()),
  );

  // ======================
  // 🔥 API Services
  // ======================

  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl()));

  // ======================
  // 🔥 Data Sources
  // ======================

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(sl()),
  );

  /// ✅ Profile Data Source
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  // ======================
  // 🔥 Repositories
  // ======================

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl(), sl()),
  );

  /// ✅ Profile Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl()),
  );

  // ======================
  // 🔥 UseCases
  // ======================

  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

  /// ✅ Profile UseCase
  sl.registerLazySingleton<ProfileUseCase>(() => ProfileUseCase(sl()));

  // ======================
  // 🔥 Cubits / Blocs
  // ======================

  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));

  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl()));

  /// ✅ Profile Cubit
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl()));
}
