import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';

abstract class ClassDataSource{
  Future<String> addClass(ClassModel clase);
  Future<List<ClassModel>> getAllClass();
  Future<void> deleteClass(ClassModel clase);
  Future<void> addStudentsToClass(String idClass, List<StudentModel> students);
  Future<void> deleteStudentToClass(String idClass, String idStudent);
  Future<void> enrollStudentToClass(String idClass, String idStudent);
  Future<void> disenrollStudentToClass(String idClass, String idStudent);
}