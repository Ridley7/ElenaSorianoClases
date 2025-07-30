import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elenasorianoclases/domain/datasource/messages_data_source.dart';
import 'package:elenasorianoclases/domain/entities/message_model.dart';
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

  @override
  Future<List<MessageModel>> getMessages(String id) {
    //Obtenemos todos los mensajes del estudiante
    //1. Obtenemos la colección "messages" y referenciamos el documento por su ID.
    final docRef = _db.collection('messages').doc(id);

    //2. Obtenemos la subcolección "recordatorios" del documento.
    final messagesCollection = docRef.collection('recordatorios');

    //3. Hacemos una consulta para obtener todos los mensajes.
    return messagesCollection.get().then((snapshot) {
      //4. Convertimos los documentos a una lista de MessageModel.
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return MessageModel(
          id: doc.id,
          content: data['message'] ?? '',
          timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
          seen: data['seen'] ?? false,
        );
      }).toList();
    });


  }

  @override
  Future<void> deleteReminder(String idUser, String messageId) async {

    //Accedemos a la colección "messages" y referenciamos el documento por su ID.
    final docRef = _db.collection('messages').doc(idUser);

    //Obtenemos la subcolección "recordatorios" del documento.
    final messagesCollection = docRef.collection('recordatorios');

    //Eliminamos el mensaje específico por su ID.
    return await messagesCollection.doc(messageId).delete();

  }

  @override
  Future<void> markMessageAsSeen(String idStudent, String messageId) {

    //Accedemos a la colección "messages" y referenciamos el documento por su ID.
    final docRef = _db.collection('messages').doc(idStudent);

    //Obtenemos la subcolección "recordatorios" del documento.
    final messagesCollection = docRef.collection('recordatorios');

    //Actualizamos el campo "seen" del mensaje específico por su ID.
    return messagesCollection.doc(messageId).update({'seen': true});
  }


}