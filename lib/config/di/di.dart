import 'package:arabas_app/core/services/register_api_service.dart';
import 'package:arabas_app/features/auth/data/data_sources/register_remote_data_source.dart';
import 'package:arabas_app/features/auth/domain/repo/register_repo.dart';
import 'package:arabas_app/features/auth/domain/repo/register_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/bloc/register_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  /// API Service
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl()));

  /// DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  /// Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  /// UseCase
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  /// Cubit
  sl.registerFactory(() => RegisterCubit(sl()));
}
