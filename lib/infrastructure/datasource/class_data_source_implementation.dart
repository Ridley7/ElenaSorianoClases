import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elenasorianoclases/domain/datasource/class_data_source.dart';
import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/domain/exceptions/app_exception.dart';

class ClassDataSourceImplementation extends ClassDataSource{

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<String> addClass(ClassModel clase) async {
    try{
      //Necesito el id para algo??
      DocumentReference documentReference = await _db.collection("clases").add(clase.toJson());
      return documentReference.id;
    }catch(error){
      throw AddClassException("Error al añadir la clase: ${error.toString()}");
    }

  }

  @override
  Future<List<ClassModel>> getAllClass() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection("clases").get();

      return querySnapshot.docs
          .map((doc) => ClassModel.fromJson({
        ...doc.data() as Map<String, dynamic>,
        'id': doc.id, // Agregar el ID del documento
      }))
          .toList();
    } catch (error) {
      throw GetAllClassException("Error al obtener las clases: ${error.toString()}");
    }
  }

  @override
  Future<void> deleteClass(ClassModel clase) async {
    try{
      await _db.collection("clases").doc(clase.id).delete();
    }catch(error){
      throw DeleteClassException("Error al eliminar la clase: ${error.toString()}");
    }
  }

  @override
  Future<void> addStudentsToClass(String idClass, List<StudentModel> students) async{
    try{
      //Extraemos los IDs de los estudiantes
      List<String> studentIds = students.map((student) => student.id).toList();

      //Obtenemos la referencia a la colección de las clases
      DocumentReference classRef = _db.collection('clases').doc(idClass);

      //Hacemos el update
      //Con array union evitamos duplicidades y no machacamos datos antiguos.
      await classRef.update({"listStudent": FieldValue.arrayUnion(studentIds)});
    }catch(e){
      print("Error al agregar estudiantes: $e");
    }

  }

  @override
  Future<void> deleteStudentToClass(String idClass, String idStudent) async {
    try{
      //Obtenemos el documento
      DocumentReference classRef = _db.collection('clases').doc(idClass);
      
      //Eliminamos el ID del estudiante del array 
      await classRef.update({'listStudent': FieldValue.arrayRemove([idStudent])
      });

    }catch(e){
      print("Error al eliminar estudiantes de la clase: $e");

    }
  }

  @override
  Future<void> enrollStudentToClass(String idClass, String idStudent) async {

    try{
      //Obtenemos el documento
      DocumentReference classRef = _db.collection('clases').doc(idClass);

      //Añadimos el id del estudiante al array
      await classRef.update({"listStudent": FieldValue.arrayUnion([idStudent])});

      //Tenemos que restar una unida al contador classCount del usuario
      DocumentReference studentRef = _db.collection('estudiantes').doc(idStudent);

      //Obtenemos el class count del estudiante
      DocumentSnapshot studentSnapshot = await studentRef.get();

      if(studentSnapshot.exists){
        int currentClassCount = studentSnapshot.get("classCount") ?? 0;

        //Restamos 1 y actualizamos el classCount
        await studentRef.update({"classCount" : currentClassCount - 1});
      }else{
        throw EnrollStudentException("El estudiante $idStudent no existe en la base de datos");
      }

    }catch(e){
      throw EnrollStudentException("Error al añadir el estudiante $idStudent a la clase $idClass");
    }

  }


}