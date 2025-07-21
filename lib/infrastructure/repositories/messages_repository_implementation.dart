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

}