import 'dart:collection';

import 'package:firebase_messaging/firebase_messaging.dart';

class QueueMessageState {
  final RemoteMessage? currentMessage;
  final Queue<RemoteMessage> queue;
  final bool isVisible;

  QueueMessageState({
    required this.currentMessage,
    required this.queue,
    this.isVisible = false,
  });

  QueueMessageState copyWith({
    RemoteMessage? currentMessage,
    Queue<RemoteMessage>? queue,
    bool? isVisible,
  }) {
    return QueueMessageState(
      currentMessage: currentMessage ?? this.currentMessage,
      queue: queue ?? this.queue,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
