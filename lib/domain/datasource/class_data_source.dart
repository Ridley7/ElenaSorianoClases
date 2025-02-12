import 'package:elenasorianoclases/domain/entities/class_model.dart';

abstract class ClassDataSource{
  Future<String> addClass(ClassModel clase);
  Future<List<ClassModel>> getAllClass();
  Future<void> deleteClass(ClassModel clase);
  Future<void> copyClass(ClassModel clase);
}