import 'package:elenasorianoclases/domain/entities/message_model.dart';

abstract class MessagesRepository {
  Future<String> createTableMessages(String id);
  Future<void> addMessage(String id, String message);
  Future<List<MessageModel>> getMessages(String id);
  Future<void> deleteReminder(String idStudent, String messageId);
  Future<void> markMessageAsSeen(String idStudent, String messageId);

}