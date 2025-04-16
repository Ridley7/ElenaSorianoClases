import 'dart:async';

import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/fcm_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/info_user_provider.dart';
import 'package:elenasorianoclases/presentation/providers/queue_messages_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/menu_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  static String name = "home-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    StudentModel student = ref.watch(infoUserProvider.notifier).state;
    List<RemoteMessage> listaMensajes = ref.watch(queueMessagesProvider);
    double right = -200;
    Timer? timer;

    //AQUI ME QUEDO. HE DE HACER ESTO EN UN STATEFUL WIDGET


    void showMessage(){
      timer = Timer(const Duration(seconds: 3), () {
        //En 3 segundos animamos el mensaje
        right = -200;
        //y lo eliminamos
        ref.read(queueMessagesProvider.notifier).removeFirstMessage();

        //Comprobamos si la lista tiene mas mensajes
        if(listaMensajes.isNotEmpty){
          //Si la lista no esta vacia enseñamos un mensaje
          right = 0;
          //A los 3 segundos ocultamos el mensaje y lo eliminamos
          showMessage();
        }

      });
    }

    //Tengo un problema si llegan dos mensajes seguidos

    if(listaMensajes.isEmpty && right == -200){
      right = -200;
    }else{
      //Si la lista no esta vacia enseñamos un mensaje
      right = 0;
      //A los 3 segundos ocultamos el mensaje y lo eliminamos
      showMessage();

    }



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
              right: right,
                bottom: 100,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                child: Container(
                  width: 200,
                  height: 40,
                  color: Colors.black,
                  child: Text("Se acaba de liberar una plaza el dia 10/12/2025", style: TextStyle(color: Colors.white),),
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

