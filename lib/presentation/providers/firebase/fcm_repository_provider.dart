import 'package:elenasorianoclases/infrastructure/datasource/fcm_data_source_implementation.dart';
import 'package:elenasorianoclases/infrastructure/repositories/fcm_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fcmRepositoryProvider = Provider((ref){
  return FCMRepositoryImplementation(dataSource: FCMDataSourceImplementation());
});