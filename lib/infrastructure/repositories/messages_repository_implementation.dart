import 'package:elenasorianoclases/domain/entities/message_model.dart';
import 'package:elenasorianoclases/domain/repositories/messages_repository.dart';
import 'package:elenasorianoclases/infrastructure/datasource/messages_data_source_implementation.dart';

class MessagesRepositoryImplementation extends MessagesRepository{

  final MessagesDataSourceImplementation dataSource;

  MessagesRepositoryImplementation({required this.dataSource});

  @override
  Future<void> addMessage(String id, String message) {
    return dataSource.addMessage(id, message);
  }

  @override
  Future<String> createTableMessages(String id) {
    return dataSource.createTableMessages(id);
  }

  @override
  Future<List<MessageModel>> getMessages(String id) {
    return dataSource.getMessages(id);
  }

  @override
  Future<void> deleteReminder(String idStudent, String messageId) {
    return dataSource.deleteReminder(idStudent, messageId);
  }

}