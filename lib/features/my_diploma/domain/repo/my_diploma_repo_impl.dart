import 'package:arabas_app/features/my_diploma/data/data_sources/my_diploma_remote_data_source.dart';
import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_entity.dart';
import 'package:arabas_app/features/my_diploma/domain/repo/my_diploma_repo.dart';

class MyDiplomaRepositoryImpl implements MyDiplomaRepository {
  final MyDiplomaRemoteDataSource remoteDataSource;

  MyDiplomaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MyDiplomaEntity>> getMyDiplomas({
    required bool activeOnly,
  }) async {
    return await remoteDataSource.getMyDiplomas(activeOnly: activeOnly);
  }
}
