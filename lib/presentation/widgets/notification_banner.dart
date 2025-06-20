
//ESTE WIDGET HAY QUE REHACERLO PARA QUE FUNCIONE CON LA NUEVA IMPLEMENTACION DE COLA DE MENSAJES
import 'dart:async';

import 'package:elenasorianoclases/presentation/providers/queue_messages_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationBanner extends ConsumerStatefulWidget {
  const NotificationBanner({super.key});

  @override
  NotificationBannerState createState() => NotificationBannerState();
}

class NotificationBannerState extends ConsumerState<NotificationBanner> {
  Timer? timer;
  double right = -200;


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final messages = ref.watch(queueMessagesProvider);

    if (messages.queue.isEmpty) {
      return const SizedBox.shrink();
    }

    // Tomamos el primer mensaje de la cola
    final currentMessage = messages.currentMessage;

    return AnimatedPositioned(
      right: -200,
        bottom: 100,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        child: Container(
          width: 200,
          height: 40,
          color: Colors.black,
          alignment: Alignment.center,
          child: Text(
            currentMessage?.notification?.title ?? '',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
    );
  }
}

/*

class NotificationBanner extends ConsumerStatefulWidget {
  const NotificationBanner({Key? key}) : super(key: key);

  @override
  _NotificationBannerState createState() => _NotificationBannerState();
}

class _NotificationBannerState extends ConsumerState<NotificationBanner> {
  Timer? _timer;
  // Variable para controlar la posición: si es 0 se ve, si es -200 se oculta.
  double right = -200;

  @override
  void didUpdateWidget(covariant NotificationBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkQueue();
  }

  @override
  void initState() {
    super.initState();
    // Si llega un mensaje y se muestra, iniciamos el proceso
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkQueue();
    });
  }

  // Comprobar si hay mensaje en la cola y si no se está mostrando ya uno.
  void _checkQueue() {
    final messages = ref.read(queueMessagesProvider);
    if (messages.isNotEmpty && right == -200) {
      _showMessage();
    }
  }

  void _showMessage() {
    // Anima para mostrar el mensaje
    setState(() {
      right = 0;
    });
    // Programa el Timer para que tras 3 segundos se oculte el mensaje
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), () {
      _hideMessage();
    });
  }

  void _hideMessage() {
    // Anima para ocultar el mensaje
    setState(() {
      right = -200;
    });
    // Espera un tiempo (por ejemplo, la duración de la animación) para eliminar el mensaje
    Future.delayed(const Duration(milliseconds: 300), () {
      ref.read(queueMessagesProvider.notifier).removeFirstMessage();
      // Si aún quedan mensajes, mostrar el siguiente
      if (ref.read(queueMessagesProvider).isNotEmpty) {
        _showMessage();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(queueMessagesProvider);
    if (messages.isEmpty) {
      return const SizedBox.shrink();
    }

    // Tomamos el primer mensaje de la cola
    final currentMessage = messages.first;

    return AnimatedPositioned(
      right: right,
      bottom: 100,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: Container(
        width: 200,
        height: 40,
        color: Colors.black,
        alignment: Alignment.center,
        child: Text(
          currentMessage.notification?.body ?? '',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

 */