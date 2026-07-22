import 'package:arabas_app/features/my_diploma/data/data_sources/my_diploma_details_remote_data_source.dart';
import 'package:arabas_app/features/my_diploma/domain/entities/my_diploma_details_entity.dart';
import 'package:arabas_app/features/my_diploma/domain/repo/my_diploma_details_repo.dart';

class MyDiplomaDetailsRepositoryImpl implements MyDiplomaDetailsRepository {
  final MyDiplomaDetailsRemoteDataSource remoteDataSource;

  MyDiplomaDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MyDiplomaDetailsEntity> getMyDiplomaDetails({
    required String diplomaId,
  }) async {
    return await remoteDataSource.getDiplomaDetails(diplomaId: diplomaId);
  }
}
