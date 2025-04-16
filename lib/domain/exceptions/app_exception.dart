abstract class AppException implements Exception {
  /// {@macro app_exception}
  const AppException([this.message]);

  final String? message;

  @override
  String toString() {
    if (message?.isNotEmpty ?? false) {
      return '$runtimeType: $message';
    } else {
      return '$runtimeType: An exception occured';
    }
  }
}


class AddClassException extends AppException{
  const AddClassException([super.message]);
}

class GetAllClassException extends AppException{
  const GetAllClassException([super.message]);
}

class DeleteClassException extends AppException{
  const DeleteClassException([super.message]);
}

class AddStudentException extends AppException{
  const AddStudentException([super.message]);
}

class GetStudentException extends AppException{
  const GetStudentException([super.message]);
}

class GetAllStudentsException extends AppException{
  const GetAllStudentsException([super.message]);
}

class DeleteStudentException extends AppException{
  const DeleteStudentException([super.message]);
}

class EnrollStudentException extends AppException{
  const EnrollStudentException([super.message]);
}

class DisenrollStudentException extends AppException{
  const DisenrollStudentException([super.message]);
}

class SaveTokenException extends AppException{
  const SaveTokenException([super.message]);
}

class DeleteTokenException extends AppException{
  const DeleteTokenException([super.message]);
}