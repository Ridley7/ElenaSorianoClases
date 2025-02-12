import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/domain/repositories/class_repository.dart';
import 'package:elenasorianoclases/infrastructure/datasource/class_data_source_implementation.dart';

class ClassRepositoryImplementation extends ClassRepository{

  ClassRepositoryImplementation({required this.dataSource});

  final ClassDataSourceImplementation dataSource;

  @override
  Future<String> addClass(ClassModel clase) async{
    return dataSource.addClass(clase);
  }

  @override
  Future<List<ClassModel>> getAllClass() {
    return dataSource.getAllClass();
  }

  @override
  Future<void> deleteClass(ClassModel clase) {
    return dataSource.deleteClass(clase);
  }
}