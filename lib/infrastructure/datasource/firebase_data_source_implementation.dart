

import 'package:elenasorianoclases/domain/datasource/login_register_data_source.dart';
import 'package:elenasorianoclases/domain/exceptions/app_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDataSourceImplementation extends LoginRegisterDataSource{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw FirebaseAuthException(
            code: e.code,
            message: 'La contraseña proporcionada es demasiado débil.',
          );
        case 'email-already-in-use':
          throw FirebaseAuthException(
            code: e.code,
            message: 'El correo electrónico ya está en uso.',
          );
        default:
          throw FirebaseAuthException(
            code: e.code,
            message: 'Ha ocurrido un error inesperado. Código: ${e.code}',
          );
      }
    } catch (e) {
      // Manejo de errores no esperados
      throw Exception('Error inesperado durante el registro.');
    }
  }

  @override
  Future<UserCredential> loginUser(String email, String password) async{
    try{
      final UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential;
    }on FirebaseAuthException catch(e){
      throw e;
    }
  }

  @override
  Future<void> recoveryPass(String email) async {

    final normalizedEmail = email.trim().toLowerCase();

    if(normalizedEmail.isEmpty){
      throw const RecoveryPassException("Introduce tu correo electronico");
    }

    try{

      await _auth.setLanguageCode('es');

      await _auth.sendPasswordResetEmail(email: normalizedEmail);

    } on FirebaseAuthException catch (e){

      switch (e.code) {
        case 'invalid-email':
          throw const RecoveryPassException('El correo electrónico no es válido');

        case 'too-many-requests':
          throw const RecoveryPassException(
            'Se han realizado demasiados intentos. Inténtalo más tarde',
          );

        case 'network-request-failed':
          throw const RecoveryPassException(
            'No se ha podido conectar. Comprueba tu conexión a Internet',
          );

        default:
          throw const RecoveryPassException(
            'No se ha podido enviar el correo de recuperación',
          );
      }


    }

  }

}