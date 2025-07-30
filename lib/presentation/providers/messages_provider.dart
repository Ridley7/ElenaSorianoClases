import 'package:elenasorianoclases/domain/entities/message_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/messages_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listMessagesProvider = StateNotifierProvider<MessagesNotifier, AsyncValue<List<MessageModel>>>((ref) {
  return MessagesNotifier(ref: ref);
});

class MessagesNotifier extends StateNotifier<AsyncValue<List<MessageModel>>> {
  MessagesNotifier({
    required this.ref
  }): super(const AsyncValue.loading());

  final Ref ref;

  //Metodo para marcar un mensaje como visto
  Future<void> markMessageAsSeen(String idStudent, String messageId) async {
    try {
      await ref.read(messagesRepositoryProvider).markMessageAsSeen(idStudent, messageId);
      // Actualizamos el estado para reflejar el cambio
      final messages = state.value?.map((msg) {
        if (msg.id == messageId) {
          return msg.copyWith(seen: true);
        }
        return msg;
      }).toList() ?? [];
      state = AsyncValue.data(messages);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteReminder(String idStudent, String messageId) async {
    try {
      await ref.read(messagesRepositoryProvider).deleteReminder(idStudent, messageId);
      // Actualizamos el estado para eliminar el mensaje de la lista
      state = AsyncValue.data(state.value?.where((msg) => msg.id != messageId).toList() ?? []);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String> createEmptyTable(String id) async {
     return await ref.read(messagesRepositoryProvider).createTableMessages(id);
  }

  Future<void> loadMessages(String idMessages) async{
    try{
      state = const AsyncValue.loading();
      final messages = await ref.read(messagesRepositoryProvider).getMessages(idMessages);

      //Ordenamos los mensajes por fecha
      messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      state = AsyncValue.data(messages);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  int getNotificationCount() {
    if (state is AsyncData<List<MessageModel>>) {
      final messages = state.value ?? [];
      return messages.where((message) => !message.seen).length;
    }
    return 0;
  }

  void clearMessages() {
    state = const AsyncValue.data([]); // o .loading() si prefieres
  }

}