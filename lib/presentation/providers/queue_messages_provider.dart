import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final queueMessagesProvider = StateNotifierProvider<QueueMessagesNotifier, List<RemoteMessage>>((ref){
  return QueueMessagesNotifier();
});

class QueueMessagesNotifier extends StateNotifier<List<RemoteMessage>>{
  QueueMessagesNotifier() : super([]);

  void addMessage(RemoteMessage message){
    print("Mensaje añadido: ${message.notification?.title}");
    state = [...state, message];
  }

  void removeFirstMessage(){
    if(state.isNotEmpty){
      state = state.sublist(1);
    }
  }

}