

import 'package:elenasorianoclases/domain/datasource/login_register_data_source.dart';
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

      /*
      else if(e.code == 'invalid-email'){
        print('');
      }

       */

      print("ERROR ES:");
      print(e.code);
      throw e;
    }
  }

}