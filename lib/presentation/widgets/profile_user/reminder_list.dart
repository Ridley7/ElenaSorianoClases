import 'package:elenasorianoclases/presentation/providers/messages_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ReminderList extends ConsumerStatefulWidget {
  const ReminderList({
    super.key,
    required this.idMessages,
    required this.idStudent,
  });

  final String idMessages;
  final String idStudent;

  @override
  ReminderListState createState() => ReminderListState();
}

class ReminderListState extends ConsumerState<ReminderList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      ref.read(listMessagesProvider.notifier).loadMessages(widget.idMessages);
    });
  }

  /*
@override
void didUpdateWidget(ProfileStudentScreen oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.student.id != widget.student.id) {
    ref.read(listMessagesProvider.notifier).loadMessages(widget.student.idMessages);
  }
}
 */

  @override
  Widget build(BuildContext context) {

    final messagesAsync = ref.watch(listMessagesProvider);

    return Expanded(
        child: messagesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error:(error, stack) => const Center(child: Text("Error al cargar mensajes")),
          data: (messages){
            if(messages.isEmpty){
              return const Center(child: Text("No hay recordatorios"));
            }

            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                return Dismissible(
                  key: Key(msg.id),
                  direction: DismissDirection.startToEnd,
                  confirmDismiss: (_) => confirmDelete(msg.id),
                  background: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFBDC4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg.content,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              DateFormat('dd/MM/yyyy').format(msg.timestamp),
                              style: const TextStyle(color: Colors.grey),
                            ),

                            const Spacer(),

                            Icon(
                              msg.seen ? Icons.check_circle : Icons.check_circle_outline,
                              color: msg.seen ? Colors.green : Colors.grey,

                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            );
          },
        )
    );
  }

  Future<bool> confirmDelete(String msgId) async{
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar recordatorio"),
        content: const Text("¿Estás seguro de que quieres eliminar este recordatorio?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              //AQUI ME QUEDO. Hay que comprobar que se borre esto correctamente.
              OverlayLoadingView.show(context);
              await ref.read(listMessagesProvider.notifier).deleteReminder(widget.idMessages, msgId);
              OverlayLoadingView.hide();
              context.pop();
            },
            child: const Text("Eliminar"),
          ),
        ],
      ),
    ) ?? false;
  }

}