import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elenasorianoclases/domain/datasource/fcm_data_source.dart';
import 'package:elenasorianoclases/domain/exceptions/app_exception.dart';

class FCMDataSourceImplementation extends FCMDataSource{

  final FirebaseFirestore _db = FirebaseFirestore.instance;



  @override
  Future<String> saveFCMToken(String token, String id) async {

    try{
      //Referencia a la coleccion
      CollectionReference collection = await _db.collection("user_tokens");

      //Comprobamos si existe un documento cpm student == id
      QuerySnapshot querySnapshot = await collection.where("student", isEqualTo: id).get();

      if(querySnapshot.docs.isNotEmpty){
        //Existe, asi que actualizamos el token
        final docRef = querySnapshot.docs.first.reference;
        await docRef.update({"token": token});
        return docRef.id;
      }else{
        //No existe, creamos uno nuevo
        final newDocRef = await collection.add({
          "student": id,
          "token": token
        });
        return newDocRef.id;
      }
    }catch (e){
      throw const SaveTokenException("Error al guardar token");
    }

  }

  @override
  Future<void> deleteFCMToken(String id) async {
    //Aqui tenemos que buscar dentro de los documentos de la coleccion 'user_tokens' un atributo que coincida con el id
    //y eliminar el documento
    try{
      CollectionReference collection = _db.collection("user_tokens");
      await collection.where("student", isEqualTo: id).get().then((querySnapshot) async {
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }
      });
  }catch(e){
      throw const DeleteTokenException("Error al eliminar token");
    }
  }

}

