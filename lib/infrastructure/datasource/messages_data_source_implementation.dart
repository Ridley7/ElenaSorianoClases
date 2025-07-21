import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elenasorianoclases/domain/datasource/messages_data_source.dart';
import 'package:elenasorianoclases/domain/exceptions/app_exception.dart';

class MessagesDataSourceImplementation implements MessagesDataSource {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> addMessage(String id, String message) async {
    //Insertamos un mensaje en la colección "messages"
    //1. Referenciamos el documento por su ID
    final docRef = _db.collection('messages').doc(id);

    try{
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        // Puedes lanzar un error personalizado, crear el documento, o lo que quieras
        throw DocumentExistenceException("El documento con id '$id' no existe.");
      }

      await docRef.update({
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });

    }catch (e) {
      throw Exception("Error al añadir el mensaje: $e");
    }

  }

  @override
  Future<String> createTableMessages(String id) async {
    //Creamos un documento vacío en la colección "messages"
    final docRef = await _db.collection('messages').add({});

    //Devolvemos el ID del documento recién creado
    return docRef.id;
  }


}