import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterClassDialog {
  static Future<void> show(BuildContext context, Function onRetry) async {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          backgroundColor: Colors.black,
          content: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: <Widget>[

              Container(
                color: Colors.black,
                padding: const EdgeInsets.only(top: 24.0),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("¿Estas seguro que quieres entrar a esta clase?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                      ),
                      textAlign: TextAlign.left,
                    ),

                  ],
                ),
              ),
            ],

          ),
          actions: [

            //Ahora necesitamos dos acciones, una para cancelar y otra para eliminar definitivamente
            //La primera acción es para cancelar
            TextButton(
                onPressed: (){
                  //context.pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)
                )
            ),

            TextButton(
                onPressed: (){
                  onRetry();
                  context.pop();
                  //Navigator.of(context).pop();
                },
                child: const Text('Entrar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFFF58076)))
            ),

          ],
        );
      },
    );
  }
}