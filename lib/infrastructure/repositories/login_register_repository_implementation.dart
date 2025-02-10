
import 'package:elenasorianoclases/domain/repositories/user_repository.dart';
import 'package:elenasorianoclases/infrastructure/datasource/firebase_data_source_implementation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRegisterRepositoryImplementation extends LoginRegisterRepository{

  LoginRegisterRepositoryImplementation({required this.loginRegisterDataSource});

  final FirebaseDataSourceImplementation loginRegisterDataSource;


  @override
  Future<UserCredential> registerUser(String email, String password) {
    return loginRegisterDataSource.registerUser(email, password);
  }

}