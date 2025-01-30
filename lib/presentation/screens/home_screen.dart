import 'package:elenasorianoclases/presentation/widgets/menu_item_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static String name = "home-screen";

  final List<MenuItemWidget> optionsMainMenu = [
    const MenuItemWidget(
      title: 'Horario',
      icon: Icons.schedule,
      route: "/schedule",
    ),

    const MenuItemWidget(
        title: 'Estudiantes',
        icon: Icons.person,
        route: "/students"
    ),

    const MenuItemWidget(
      title: 'Clases',
      icon: Icons.class_outlined,
      route: "/class",
    )
  ];

  @override
  Widget build(BuildContext context) {
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

