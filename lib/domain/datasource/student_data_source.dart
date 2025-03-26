import 'package:elenasorianoclases/domain/entities/student_model.dart';

abstract class StudentDataSource{
  Future<String> addStudent(StudentModel student);
  Future<StudentModel> getStudent(String uid);
  Future<List<StudentModel>> getAllStudents();
  Future<void> deleteStudent(String id);
  Future<void> setAccess(bool access, String id);
  Future<void> updateClassCount(int classCount, String id);
}