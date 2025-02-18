import 'package:elenasorianoclases/presentation/widgets/background_login.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotAllowedScreen extends StatelessWidget {
  const NotAllowedScreen({super.key});

  static String name = "not-allowed-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundLogin(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  textAlign: TextAlign.center,
                    "No tiene acceso.\nSolicite ayuda al administrador",
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 12),

                IconButton(
                    onPressed: ()async{
                      OverlayLoadingView.show(context);
                      await FirebaseAuth.instance.signOut();
                      OverlayLoadingView.hide();
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 80,
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}
