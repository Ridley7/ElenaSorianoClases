import 'package:elenasorianoclases/domain/entities/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderDetailScreen extends StatelessWidget {
  const ReminderDetailScreen({
    super.key,
    required this.reminder,
  });

  static String name = "reminder-detail-screen";

  final MessageModel reminder;

  //Aqui hay que marcar que el mensaje ya ha sido visto


  @override
  Widget build(BuildContext context) {

    //Hay que marcar el mensaje como visto

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Recordatorio"),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(reminder.content),
                const SizedBox(height: 20,),
                Text(
                  DateFormat('dd/MM/yyyy').format(reminder.timestamp),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
