import 'package:elenasorianoclases/domain/entities/student_model.dart';

abstract class StudentDataSource{
  Future<String> addStudent(StudentModel student);
  Future<StudentModel> getStudent(String uid);
}