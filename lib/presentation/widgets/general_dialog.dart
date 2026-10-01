import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GeneralDialog {
  static Future<bool?> show(
      BuildContext context, {
        required String message,
        String acceptText = 'Aceptar',
        String cancelText = 'Cancelar'
      }) async {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          backgroundColor: Colors.black,
          content: Container(
            color: Colors.black,
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
            message,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),
              textAlign: TextAlign.left,
            ),
          ),
          actions: [

            //Ahora necesitamos dos acciones, una para cancelar y otra para eliminar definitivamente
            //La primera acción es para cancelar
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: Text(
                    cancelText,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                )
            ),

            TextButton(
                onPressed: (){
                  context.pop(true);
                  //Navigator.of(context).pop();
                },
                child: Text(
                    acceptText, style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF58076)
                )
                )
            ),

          ],
        );
      },
    );
  }
}