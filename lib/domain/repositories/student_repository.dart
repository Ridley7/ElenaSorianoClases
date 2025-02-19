import 'package:elenasorianoclases/domain/entities/student_model.dart';

abstract class StudentRepository{
  Future<String> addStudent(StudentModel student);
  Future<StudentModel> getStudent(String uid);
  Future<List<StudentModel>> getAllStudents();
  Future<void> deleteStudent(String id);
}