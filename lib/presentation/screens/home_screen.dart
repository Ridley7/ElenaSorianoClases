import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/fcm_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/info_user_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/menu_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  static String name = "home-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    StudentModel student = ref.watch(infoUserProvider.notifier).state;

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
        title: 'HTTP',
        icon: Icons.http,
        callback: () async{
          final url = Uri.parse("https://us-central1-elenasoriano-clases.cloudfunctions.net/helloWorld");
          final response = await http.get(url);

          if (response.statusCode == 200) {
            print("Respuesta: ${response.body}");
          } else {
            print("Error: ${response.statusCode}");
          }
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
        child: Column(
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
      ),
    );
  }
}

