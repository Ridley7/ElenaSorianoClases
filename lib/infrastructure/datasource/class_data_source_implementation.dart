import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elenasorianoclases/domain/datasource/class_data_source.dart';
import 'package:elenasorianoclases/domain/entities/class_model.dart';
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
  Future<void> copyClass(ClassModel clase) {
    // TODO: implement copyClass
    throw UnimplementedError();
  }

  @override
  Future<void> deleteClass(ClassModel clase) async {
    try{
      await _db.collection("clases").doc(clase.id).delete();
    }catch(error){
      throw DeleteClassException("Error al eliminar la clase: ${error.toString()}");
    }
  }


}