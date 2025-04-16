import 'package:elenasorianoclases/presentation/providers/queue_messages_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elenasorianoclases/config/app_theme/app_theme.dart';
import 'package:elenasorianoclases/config/router/app_router.dart';
import 'package:elenasorianoclases/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

final container = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  //Solicitamos permisos
  //NotificationSettings settings = await firebaseMessaging.requestPermission(
  await firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true
  );

  /*
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("Permisos de notificación concedidos");
  } else {
    print("Permisos de notificación denegados");
  }
  */

  //Llamamos a la función de inicialización de Firebase Messaging
  await initFirebaseMessaging();

  await initializeDateFormatting();
  
  runApp(
      UncontrolledProviderScope(
        container: container,
          child: const MyApp()
      )
  );
}

Future<void> initFirebaseMessaging() async {

  //Configuramos el manejo de mensajes en segundo plano
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //Configuramos el manejes de mensajes en primer plano
  FirebaseMessaging.onMessage.listen((RemoteMessage message){
    //Metemos mensajes en el provider
    container.read(queueMessagesProvider.notifier).addMessage(message);
    print("Mensaje en primer plano: ${message.notification?.title}");

  });

  //Configuramos cuando se abre la app desde una notificación
  FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingAppOpened);
}

void _firebaseMessagingAppOpened(RemoteMessage message) {
  final String? ruta = message.data['ruta'];
  if(ruta != null) {
    //Aquí se puede abrir la ruta deseada
    //Por ejemplo, si la ruta es "/home", se puede hacer lo siguiente:
    appRouter.go(ruta);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Mensaje en segundo plano: ${message.notification?.title}");
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
      localizationsDelegates: const[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      title: 'Flutter Demo',
      theme: AppTheme(isDarkMode: false).getTheme(),
    );


  }
}

