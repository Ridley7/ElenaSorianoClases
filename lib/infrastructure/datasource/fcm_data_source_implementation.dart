import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elenasorianoclases/domain/datasource/fcm_data_source.dart';

class FCMDataSourceImplementation extends FCMDataSource{

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<String> saveFCMToken(String token, String id) async {
    //AQUI ME QUEDO
    //Ahora hay que comprobar si existe una entrada para el id del usuario, si la hay, hay que actualizar
    //el token, si no la hay hay que hacer una simple inserción.

    DocumentReference documentReference = await _db.collection("user_tokens").add({"token" : token});
    return documentReference.id;
  }

}

