import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elenasorianoclases/domain/datasource/messages_data_source.dart';
class MessagesDataSourceImplementation implements MessagesDataSource {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> addMessage(String id, String message) async {
    //Insertamos un mensaje en la colección "messages"
    //1. Referenciamos el documento por su ID.
    final docRef = _db.collection('messages').doc(id);

    //2. Traer la coleccion recordatorios de docRef
    final messagesCollection = docRef.collection('recordatorios');

    //3. Insertar el mensaje en la subcolección "recordatorios"
    final newMessageRef = messagesCollection.doc(); // Creamos un nuevo documento con ID autogenerado

    await newMessageRef.set({
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'seen': false, // Inicialmente no visto
    });

  }

  @override
  Future<String> createTableMessages(String id) async {
    //Creamos un documento vacío en la colección "messages"
    final docRef = await _db.collection('messages').add({});

    //Con la referencia del documento, actualizamos la informacion del estudiante
    await _db.collection('estudiantes').doc(id).update({'idMessages': docRef.id});


    //Devolvemos el ID del documento recién creado
    return docRef.id;
  }


}