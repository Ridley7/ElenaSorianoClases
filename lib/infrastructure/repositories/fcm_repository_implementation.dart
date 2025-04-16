import 'package:elenasorianoclases/domain/repositories/fcm_repository.dart';
import 'package:elenasorianoclases/infrastructure/datasource/fcm_data_source_implementation.dart';

class FCMRepositoryImplementation extends FCMRepository{

  FCMRepositoryImplementation({required this.dataSource});

  final FCMDataSourceImplementation dataSource;

  @override
  Future<String> saveFCMToken(String token, String id) async {
    return await dataSource.saveFCMToken(token, id);
  }

  @override
  Future<void> deleteFCMToken(String id) async {
    return await dataSource.deleteFCMToken(id);
  }

}