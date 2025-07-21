import 'package:elenasorianoclases/infrastructure/datasource/messages_data_source_implementation.dart';
import 'package:elenasorianoclases/infrastructure/repositories/messages_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagesRepositoryProvider = Provider((ref){
  return MessagesRepositoryImplementation(dataSource: MessagesDataSourceImplementation());
});