import 'package:elenasorianoclases/domain/entities/message_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/messages_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listMessagesProvider = StateNotifierProvider<MessagesNotifier, List<MessageModel>>((ref) {
  return MessagesNotifier(ref: ref);
});

class MessagesNotifier extends StateNotifier<List<MessageModel>>{
  MessagesNotifier({
    required this.ref
  }): super([]);

  final Ref ref;

  //Aqui hay que llamar a createTableMessage
  Future<String> createEmptyTable(String id) async {
     return await ref.read(messagesRepositoryProvider).createTableMessages(id);
  }

}