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

}