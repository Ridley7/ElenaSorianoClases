import 'package:elenasorianoclases/infrastructure/datasource/class_data_source_implementation.dart';
import 'package:elenasorianoclases/infrastructure/repositories/class_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final classRepositoryProvider = Provider((ref){
  return ClassReposityImplementation(dataSource: ClassDataSourceImplementation());
});
