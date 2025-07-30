import 'package:elenasorianoclases/presentation/providers/info_user_provider.dart';
import 'package:elenasorianoclases/presentation/providers/messages_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class StudentRemiderListScreen extends ConsumerStatefulWidget {
  const StudentRemiderListScreen({super.key});

  static String name = "reminder-list-screen";

  @override
  StudentRemiderListScreenState createState() => StudentRemiderListScreenState();
}

class StudentRemiderListScreenState extends ConsumerState<StudentRemiderListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Obtenemos id de mensajes del usuario
    String idMessages = ref.read(infoUserProvider).idMessages;

    Future.microtask((){
      //Cargamos los recordatorios del usuario
      ref.read(listMessagesProvider.notifier).loadMessages(idMessages);
    });
  }

  @override
  Widget build(BuildContext context) {

    final remindersAsync = ref.watch(listMessagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Recordatorios"),),
      body: SafeArea(
          child: remindersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => const Center(child: Text("Error al cargar recordatorios")),
            data: (reminders){
              if(reminders.isEmpty){
                return const Center(child: Text("No hay recordatorios"));
              }

              return ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {

                  final reminder = reminders[index];

                  return InkWell(
                    onTap: () {
                      //context.push("");
                      context.push(
                        '/student_reminder_list/reminder_detail',
                        extra: reminder,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFFFBDC4), width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          reminder.content,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        //Hay que formatear la fecha para mostrarla correctamente en dd/mm/yyyy
                        subtitle: Text(DateFormat('dd/MM/yyyy').format(reminder.timestamp)),
                        //Ponemos icono para ver si el mensaje ha sido visto o no
                        trailing: Icon(
                          reminder.seen ? Icons.check_circle : Icons.circle,
                          color: reminder.seen ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              );

            }
          )

      ),
    );
  }
}
