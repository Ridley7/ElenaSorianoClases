//AQUI ME QUEDO.
//Solo queda capar lo que puede ver un estudiante y lo que puede ver un profesor

import 'package:elenasorianoclases/config/constants/enums.dart';
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

    List<MenuItemWidget> buildMenuByRole(BuildContext context, String role, WidgetRef ref){
      List<MenuItemWidget> menu = [];

      menu.add(
        MenuItemWidget(
            title: 'Horario',
            icon: Icons.schedule,
            callback: (){
              context.go("/schedule");
            }
        )
      );

      if(role == RolType.lecturer){
        menu.add(
          MenuItemWidget(
            title: 'Estudiantes',
            icon: Icons.person,
            callback: (){
              context.push("/students");
            },
          )
        );

        menu.add(
          MenuItemWidget(
            title: 'Clases',
            icon: Icons.class_outlined,
            callback: (){
              context.push("/class");
            },
          )
        );
      }


      menu.add(
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
      );

      return menu;
    }

    final List<MenuItemWidget> optionsMainMenu = buildMenuByRole(context, student.rol, ref);

    return Scaffold(
      appBar: AppBar(title: const Text("Menú"), centerTitle: true,),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [

            AnimatedPositioned(
              right: messageState.isVisible ? 0 : -380,
                bottom: 100,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFFFBDC4)
                  ),
                  child: Center(
                    child: Text(
                      currentMessage?.notification?.body ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
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
                Text("${student.name} ${student.surename}"),
                student.rol == RolType.student ?
                Text("Clases a recuperar: ${student.classCount}")
                : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

