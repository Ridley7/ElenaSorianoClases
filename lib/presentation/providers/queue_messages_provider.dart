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

  void addMessage(RemoteMessage message){

    print("Mensaje añadido: ${message.notification?.title}");
    final updatedQueue = Queue<RemoteMessage>.from(state.queue)..add(message);
    state = state.copyWith(queue: updatedQueue);
    //Curioso como despues de actualizar el estado, se llama a processQueue
    processQueue();
  }

  Future<void> processQueue() async{
    //Si estamos procesando un mensaje no hacemos nada
    if(isProcessing) return;

    //Mientras la cola no esté vacia, hacemos cosas
    while (state.queue.isNotEmpty){
      final updatedQueue = Queue<RemoteMessage>.from(state.queue);
      final currentMessage = updatedQueue.removeFirst();

      //Mostamos el mensaje actual
      state = QueueMessageState(
          currentMessage: currentMessage,
          queue: updatedQueue
      );

      await Future.delayed(const Duration(seconds: 3));

      //Ocultamos el mensaje actual
      state = QueueMessageState(
          currentMessage: null,
          queue: updatedQueue
      );
      //Esperamos 300 milisegundos antes de procesar el siguiente mensaje ¿Why?
      await Future.delayed(const Duration(milliseconds: 300));
    }

    isProcessing = false;

  }
}

