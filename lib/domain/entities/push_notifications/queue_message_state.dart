import 'dart:collection';

import 'package:firebase_messaging/firebase_messaging.dart';

class QueueMessageState{
  final RemoteMessage? currentMessage;
  final Queue<RemoteMessage> queue;

  QueueMessageState({
    required this.currentMessage,
    required this.queue,
  });

  QueueMessageState copyWith({
    RemoteMessage? currentMessage,
    Queue<RemoteMessage>? queue,
  }) {
    return QueueMessageState(
      currentMessage: currentMessage ?? this.currentMessage,
      queue: queue ?? this.queue,
    );
  }
}