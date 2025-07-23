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

  void clearMessages() {
    state = const AsyncValue.data([]); // o .loading() si prefieres
  }

}