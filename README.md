# ElenaSorianoClases
App para gestionar horarios de clase

Para poner en marcha el emulador de cloud functions:
firebase emulators:start

Para despliegue de funciones:
firebase deploy --only functions


# Produccion
Cambiar nombre del bundle id
```
flutter pub run change_app_package_name:main com.elenasoriano.elenasorianoclases
```

Cambiar icono de la app
```
flutter pub run flutter_launcher_icons
```

Para cambiar el splash screen:
```
flutter pub run flutter_native_splash:create
```

Para generar el AAB:
```
flutter build appbundle
```


