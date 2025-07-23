import 'package:elenasorianoclases/domain/entities/message_model.dart';

abstract class MessagesDataSource{
  Future<String> createTableMessages(String id);
  Future<void> addMessage(String id, String message);
  Future<List<MessageModel>> getMessages(String id);
}