import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/domain/repositories/student_repository.dart';
import 'package:elenasorianoclases/infrastructure/datasource/student_data_source_implementation.dart';

class StudentRepositoryImplementation extends StudentRepository{

  StudentRepositoryImplementation({required this.dataSource});

  final StudentDataSourceImplementation dataSource;

  @override
  Future<String> addStudent(StudentModel student) {
    return dataSource.addStudent(student);
  }

  @override
  Future<StudentModel> getStudent(String uid) {
    return dataSource.getStudent(uid);
  }

  @override
  Future<List<StudentModel>> getAllStudents() {
    return dataSource.getAllStudents();
  }

  @override
  Future<void> deleteStudent(String id) {
    return dataSource.deleteStudent(id);
  }



}