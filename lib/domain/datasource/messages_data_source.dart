abstract class MessagesDataSource{
  Future<String> createTableMessages(String id);
  Future<void> addMessage(String id, String message);
}