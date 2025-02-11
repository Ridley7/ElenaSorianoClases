import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRegisterRepository{
  Future<UserCredential> registerUser(String email, String password);
  Future<UserCredential> loginUser(String email, String password);
}