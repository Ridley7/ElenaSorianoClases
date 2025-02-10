
import 'package:elenasorianoclases/infrastructure/datasource/firebase_data_source_implementation.dart';
import 'package:elenasorianoclases/infrastructure/repositories/login_register_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRegisterRepository = Provider((ref){
  return LoginRegisterRepositoryImplementation(loginRegisterDataSource: FirebaseDataSourceImplementation());
});