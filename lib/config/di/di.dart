import 'package:arabas_app/core/services/register_api_service.dart';
import 'package:arabas_app/features/auth/data/data_sources/login_remote_data_source.dart';
import 'package:arabas_app/features/auth/data/data_sources/register_remote_data_source.dart';
import 'package:arabas_app/features/auth/domain/repo/login_repo.dart';
import 'package:arabas_app/features/auth/domain/repo/login_repo_impl.dart';
import 'package:arabas_app/features/auth/domain/repo/register_repo.dart';
import 'package:arabas_app/features/auth/domain/repo/register_repo_impl.dart';
import 'package:arabas_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:arabas_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:arabas_app/features/auth/presentation/bloc/login_cubit.dart';
import 'package:arabas_app/features/auth/presentation/bloc/register_cubit.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ======================
  // 🔥 External Services
  // ======================

  sl.registerLazySingleton<Dio>(() => Dio());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

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

  // ======================
  // 🔥 Repositories
  // ======================

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));

  // ======================
  // 🔥 UseCases
  // ======================

  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

  // ======================
  // 🔥 Cubits / Blocs
  // ======================

  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));

  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl()));
}
