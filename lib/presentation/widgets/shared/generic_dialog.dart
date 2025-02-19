import 'package:flutter/material.dart';

class GenericDialog {
  static Future<void> show(BuildContext context, String title, String message, Function onRetry) async {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: const Color(0xFF00132B),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          content: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: <Widget>[


              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                color: const Color(0xFF00132B),
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(title,
                        style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)
                    ),
                    const SizedBox(height: 16,),
                    Text(message,
                      style:
                      const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w300
                      ),
                      textAlign: TextAlign.center
                    )
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
                  //context.pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFFF58076)))
            ),

          ],
        );
      },
    );
  }
}