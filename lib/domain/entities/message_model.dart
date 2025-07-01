class MessageModel{
  final String id;
  final String content;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.content,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'MessageModel{id: $id, content: $content, timestamp: $timestamp}';
  }
}