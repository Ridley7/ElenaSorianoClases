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
      //Referenciamos a los documentos de los estudiantes
      List<DocumentReference> studentRefs = clase.listStudent
      .map((estudianteId) => _db.collection("estudiantes").doc(estudianteId))
      .toList();

      //Actualizamos el classcount de los estudiantes pero en paralelo ¿?¿?
      await Future.wait(studentRefs.map((ref){
        return ref.update({
          "classCount" : FieldValue.increment(1)
        }).catchError((e){
          // Manejo de error individual por estudiante
          print("Error al actualizar classCount de ${ref.id}: $e");
        });
      }));

      await _db.collection("clases").doc(clase.id).delete();
    }catch(error, stackTrace){
      print("Error en deleteClass: $error\n$stackTrace");
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

      //Verificamos si el documento de la clase existe
      DocumentSnapshot classSnapshot = await classRef.get();

      if (!classSnapshot.exists) {
        throw const EnrollStudentException("ERROR es probable que la clase haya sido borrada en este instante.");
      }

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
      // Si ya es una EnrollStudentException, la relanzamos sin modificarla
      if (e is EnrollStudentException) {
        rethrow;
      }
      // Si es otro error, lanzamos la excepción general
      throw EnrollStudentException("Error al añadir el estudiante $idStudent a la clase $idClass");

    }

  }

  @override
  Future<void> disenrollStudentToClass(String idClass, String idStudent) async {
    try{
      //Obtenemos el documento
      DocumentReference classRef = _db.collection('clases').doc(idClass);

      //AQUI ME QUEDO, HAY QUE COMPROBAR QUE SI UN ALUMNO SE DESAPUNTA ESTA CLASE
      //SIGA EXISTIENDO DE IGUAL MANERA QUE HICIMOS COMO EN EL METODO DE ARRIBA
      //ADEMAS ASI SE EVITA QUE SE TENGA QUE RECUPERAR UNA CLASE INDEBIDAMENTE

      //SEUNGDA FAENA: CUANDO TE CARGAS UNA CLASE A ESOS ESTUDIANTES LES DEBES CLASE? SI
      //POR LO TANTO A LOS ESTUDIANTES QUE ESTEN APUNTADOS A UNA CLASE QUE SE VAYA A ELIMINAR
      //DEBEMOS INCREMENTAR EN 1 SU COUNTCLASS

      //Eliminamos el ID del estudiante del array
      await classRef.update({'listStudent': FieldValue.arrayRemove([idStudent])
      });

      //Obtenemos el class count del estudiante
      DocumentReference studentRef = _db.collection("estudiantes").doc(idStudent);
      DocumentSnapshot studentSnapshot = await studentRef.get();

      if(studentSnapshot.exists){
        int currentClassCoint = studentSnapshot.get("classCount") ?? 0;
        //Restamos 1 y actualizamos el classCount
        await studentRef.update({"classCount" : currentClassCoint + 1});
      }else{
        throw DisenrollStudentException("Error al desapuntar al estudiante $idStudent de la clase $idClass");
      }

    }catch(e){
      print("Error al desapuntar a un estudiante de la clase: $e");

    }
  }


}