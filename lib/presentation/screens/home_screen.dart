//AQUI ME QUEDO.
//1. HAY QUE PROBAR LA COLA DE MENSAJES. EN EL README HAY INSTRUCCIONES.
//2. CUANDO LA COLA FUNCIONE. HAY QUE HACER EL WIDGET QUE MUESTRE LOS MENSAJES.


import 'package:elenasorianoclases/domain/entities/push_notifications/queue_message_state.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/fcm_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/info_user_provider.dart';
import 'package:elenasorianoclases/presentation/providers/queue_messages_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/menu_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  static String name = "home-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    StudentModel student = ref.watch(infoUserProvider.notifier).state;
    QueueMessageState messageState = ref.watch(queueMessagesProvider);
    final currentMessage = messageState.currentMessage;

    final List<MenuItemWidget> optionsMainMenu = [
      MenuItemWidget(
          title: 'Horario',
          icon: Icons.schedule,
          callback: (){
            context.go("/schedule");
          }
      ),

      MenuItemWidget(
          title: 'Estudiantes',
          icon: Icons.person,
          callback: (){
            context.push("/students");
          },
      ),

      MenuItemWidget(
        title: 'Clases',
        icon: Icons.class_outlined,
        callback: (){
          context.push("/class");
        },
      ),

      MenuItemWidget(
          title: 'Logout',
          icon: Icons.logout,
        callback: () async{
            OverlayLoadingView.show(context);
            //Eliminamos el token para dejar de recibir notificaciones
            String id = ref.read(infoUserProvider).id;
            await ref.read(fcmRepositoryProvider).deleteFCMToken(id);

            await FirebaseAuth.instance.signOut();
            OverlayLoadingView.hide();

            context.go("/login_signup");

        },
      )
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Menú"), centerTitle: true,),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [

            AnimatedPositioned(
              right: currentMessage != null ? 0 : -200,
                bottom: 100,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                child: Container(
                  width: 200,
                  height: 40,
                  color: Colors.black,
                  child: Text(
                    currentMessage?.notification?.title ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
            ),


            Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16
                      ),
                      itemCount: optionsMainMenu.length,
                      itemBuilder: (context, index){
                        return optionsMainMenu[index];
                      }
                  ),
                ),

                Text("Clases a recuperar: ${student.classCount}")
              ],
            ),
          ],
        ),
      ),
    );
  }
}

