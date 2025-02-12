import 'package:elenasorianoclases/domain/entities/class_model.dart';

abstract class ClassRepository{
  Future<String> addClass(ClassModel clase);
  Future<List<ClassModel>> getAllClass();
  Future<void> deleteClass(ClassModel clase);
}