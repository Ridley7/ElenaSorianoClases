import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elenasorianoclases/domain/datasource/student_data_source.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/domain/exceptions/app_exception.dart';

class StudentDataSourceImplementation extends StudentDataSource{

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  @override
  Future<String> addStudent(StudentModel student) async {
    try{
      DocumentReference documentReference = await _db.collection("estudiantes").add(student.toJson());
      return documentReference.id;
    }catch(error){
      throw AddStudentException("Error al añadir al estudiante: ${error.toString()}");
    }
  }

  @override
  Future<StudentModel> getStudent(String uid) async {
    QuerySnapshot querySnapshot = await _db
        .collection("estudiantes")
        .where("uid", isEqualTo: uid)
        .get();
    AQUI ME QUEDO
  }

  /*
  @override
Future<StudentModel?> getStudent(String uid) async {
  QuerySnapshot querySnapshot = await _db
      .collection("estudiantes")
      .where("uid", isEqualTo: uid)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    var studentData = querySnapshot.docs.first.data() as Map<String, dynamic>;
    return StudentModel.fromJson(studentData);
  }

  return null; // Retorna null si no se encuentra el estudiante
}
   */

/*
return StudentModel.fromJson(studentData).copyWith(id: querySnapshot.docs.first.id);

 */

}