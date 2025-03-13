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

    try{
      QuerySnapshot querySnapshot = await _db
          .collection("estudiantes")
          .where("uid", isEqualTo: uid)
          .limit(1)
          .get();


      if(querySnapshot.docs.isNotEmpty){
        var studentData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        return StudentModel.fromJson(studentData).copyWith(id: querySnapshot.docs.first.id);
      }

      throw Exception("No se encontró el estudiante con uid: $uid");
    }catch(error){
      throw GetStudentException("Error al obtener el estudiante con uid: $uid");
    }

  }

  @override
  Future<List<StudentModel>> getAllStudents() async {
    try{
      QuerySnapshot querySnapshot = await _db
          .collection("estudiantes")
          .where("rol", isEqualTo: "student")
          .get();

      return querySnapshot.docs
          .map((doc) => StudentModel.fromJson({
        ...doc.data() as Map<String, dynamic>,
        'id': doc.id
      })).toList();
    }catch(error){
      throw GetAllStudentsException("Error al obtener todos los estudiantes: ${error.toString()}");
    }
  }

  @override
  Future<void> deleteStudent(String id) async {
    try{
      await _db.collection('estudiantes').doc(id).delete();
    }catch(e){
      throw DeleteStudentException("Error al eliminar estudiante con id: $id");
    }
  }

  @override
  Future<void> setAccess(bool access, String id) async {
    await _db.collection('estudiantes').doc(id).update({'access': access});
  }

}