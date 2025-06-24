import 'dart:collection';

import 'package:elenasorianoclases/domain/entities/push_notifications/queue_message_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final queueMessagesProvider = StateNotifierProvider<QueueMessagesNotifier, QueueMessageState>((ref){
  return QueueMessagesNotifier();
});

class QueueMessagesNotifier extends StateNotifier<QueueMessageState>{
  bool isProcessing = false;

  QueueMessagesNotifier() : super(QueueMessageState(
    currentMessage: null,
    queue: Queue<RemoteMessage>(),
  ));

  void addMessage(RemoteMessage message)async {

    print("Mensaje añadido: ${message.notification?.title}");
    print("En la cola hay ${state.queue.length} mensajes");
    final updatedQueue = Queue<RemoteMessage>.from(state.queue)..add(message);
    state = state.copyWith(queue: updatedQueue);

    //Solo procesamos la cola si no estamos procesando un mensaje
    if(!isProcessing){
      await processQueue();
    }
  }

  Future<void> processQueue() async{
    isProcessing = true;

    //Mientras la cola no esté vacia, hacemos cosas
    while (state.queue.isNotEmpty){
      final updatedQueue = Queue<RemoteMessage>.from(state.queue);
      final currentMessage = updatedQueue.removeFirst();

      //Mostamos el mensaje actual
      state = QueueMessageState(
          currentMessage: currentMessage,
          queue: updatedQueue,
        isVisible: true
      );

      await Future.delayed(const Duration(seconds: 3));

      //Ocultamos el mensaje actual
      // Ocultar animación
      state = state.copyWith(isVisible: false);

      //Esperamos 300 milisegundos antes de procesar el siguiente mensaje ¿Why?
      await Future.delayed(const Duration(milliseconds: 500));
    }

    isProcessing = false;

  }
}

