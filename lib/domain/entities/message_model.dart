import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  final String id;
  final String content;
  final DateTime timestamp;
  final bool seen;

  MessageModel({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.seen,
  });

  @override
  String toString() {
    return 'MessageModel{id: $id, content: $content, timestamp: $timestamp}';
  }

  //Metodo para convertir un Map a MessageModel
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      content: json['content'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      seen: json['seen'] as bool? ?? false,
    );
  }

  //Metodo para convertir un MessageModel a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
      'seen': seen,
    };
  }

  //Metodo CopyWith
  MessageModel copyWith({
    String? id,
    String? content,
    DateTime? timestamp,
    bool? seen,
  }) {
    return MessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      seen: seen ?? this.seen,
    );
  }
}