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