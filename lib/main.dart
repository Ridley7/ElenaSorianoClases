import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elenasorianoclases/config/app_theme/app_theme.dart';
import 'package:elenasorianoclases/config/router/app_router.dart';
import 'package:elenasorianoclases/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  await initializeDateFormatting();
  
  runApp(
      const ProviderScope(
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      locale: const Locale('es', 'ES'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES')
      ],
      localizationsDelegates: context.localizationDelegates,
      title: 'Flutter Demo',
      theme: AppTheme(isDarkMode: false).getTheme(),
    );


  }
}