import 'package:elenasorianoclases/domain/repositories/user_repository.dart';
import 'package:elenasorianoclases/infrastructure/datasource/firebase_data_source_implementation.dart';

class UserRepositoryImplementation extends UserRepository{

  final FirebaseDataSourceImplementation userDataSource;

  UserRepositoryImplementation({required this.userDataSource});

  @override
  Future<void> registerUser(String email, String password) {
    return userDataSource.registerUser(email, password);
  }

}