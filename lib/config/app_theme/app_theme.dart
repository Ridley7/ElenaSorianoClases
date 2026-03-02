import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = false,
  });

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFFFFBDC4),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,


      iconTheme: const IconThemeData(
          color: Color(0xFFFFBDC4)
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if(states.contains(WidgetState.selected)){
                return Colors.white;
              }
              return const Color(0xFFFFBDC4);
            }
        ),

        trackColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if(states.contains(WidgetState.selected)){
                return const Color(0xFFFFBDC4);
              }
              return const Color(0xffa8a8a8);
            }
        ),

        trackOutlineColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states){
              return Colors.transparent;
            }
        ),

        thumbIcon: WidgetStateProperty.resolveWith<Icon>(
              (Set<WidgetState> states) {
            return const Icon(Icons.circle, color: Colors.transparent);
          },
        ),
      ),

      //Configuracion del tema para los indicadores de progreso
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFFCCE2FF),
          circularTrackColor: Color(0xFFFFBDC4)
      )

  );

  AppTheme copyWith({
    bool? isDarkMode,
  }) {
    return AppTheme(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

