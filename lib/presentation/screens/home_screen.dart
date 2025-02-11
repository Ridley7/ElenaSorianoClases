import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/menu_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static String name = "home-screen";

  @override
  Widget build(BuildContext context) {


    final List<MenuItemWidget> optionsMainMenu = [
      MenuItemWidget(
          title: 'Horario',
          icon: Icons.schedule,
          callback: (){
            context.push("/schedule");
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
            await FirebaseAuth.instance.signOut();
            OverlayLoadingView.hide();

            context.go("/login_signup");
        },

        /*
        Future<void> _logout(BuildContext context) async {
    // Hacemos logout
    loading = true;
    setState(() {});
    await FirebaseAuth.instance.signOut();

    // Vamos a pantalla de login
    context.go("/login");
  }
         */
      )
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Menú"), centerTitle: true,),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
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
    );
  }
}

