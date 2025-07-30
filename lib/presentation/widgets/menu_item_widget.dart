
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.callback,
    this.notificationCount,
  });

  final String title;
  final IconData icon;
  final VoidCallback callback;
  final int? notificationCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              IconButton(
                  onPressed: callback,
                  icon: Icon(
                    icon,
                    size: 48,
                  )
              ),

              if (notificationCount != null && notificationCount! > 0)
              Positioned(
                right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${notificationCount!}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
              )

            ],
          ),

          const SizedBox(height: 8,),
          Text(title, style: const TextStyle(fontSize: 14),),

        ],
      ),
    );
  }
}
