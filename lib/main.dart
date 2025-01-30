import 'package:elenasorianoclases/config/app_theme/app_theme.dart';
import 'package:elenasorianoclases/config/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Flutter Demo',
      theme: AppTheme(isDarkMode: false).getTheme(),
    );


  }
}