abstract class MessagesRepository {
  Future<String> createTableMessages(String id);
  Future<void> addMessage(String id, String message);
}