
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    super.key, required this.title, required this.icon, required this.route,
  });

  final String title;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push(route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: (){
                if(route.isEmpty) return;
                context.push(route);
              },
              icon: Icon(
                icon,
                size: 48,
              )
          ),

          const SizedBox(height: 8,),
          Text(title, style: const TextStyle(fontSize: 14),),

        ],
      ),
    );
  }
}
