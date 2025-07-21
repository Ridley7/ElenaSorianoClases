import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elenasorianoclases/domain/datasource/messages_data_source.dart';

class MessagesDataSourceImplementation implements MessagesDataSource {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> addMessage(String id, String message) {
    // TODO: implement addMessage
    throw UnimplementedError();
  }

  @override
  Future<String> createTableMessages(String id) async {
    //Creamos un documento vacío en la colección "messages"
    final docRef = await _db.collection('messages').add({});

    //Devolvemos el ID del documento recién creado
    return docRef.id;
  }


}