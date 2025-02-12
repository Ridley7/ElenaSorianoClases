import 'package:elenasorianoclases/infrastructure/datasource/student_data_source_implementation.dart';
import 'package:elenasorianoclases/infrastructure/repositories/student_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final studentRepositoryProvider = Provider((ref){
  return StudentRepositoryImplementation(dataSource: StudentDataSourceImplementation());
});