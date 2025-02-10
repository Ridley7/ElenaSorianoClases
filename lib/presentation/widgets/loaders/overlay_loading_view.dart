import 'package:flutter/material.dart';

class OverlayLoadingView{
  static OverlayEntry? _overlay;

  static void show(BuildContext context, {Color? backgroundcolor}){
    if(_overlay != null) return;

    _overlay = OverlayEntry(builder: (BuildContext context){
      return Stack(
        children: [
          Container(
              color: backgroundcolor ?? Colors.black87,
              child: const PopScope(
                canPop: false,
                child: Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Text("Cargando..."),

                          SizedBox(height: 20.0),

                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          )
        ],
      );
    });

    Overlay.of(context).insert(_overlay!);
  }

  static hide(){
    if(_overlay == null) return;
    _overlay!.remove();
    _overlay = null;
  }
}