import 'package:elenasorianoclases/domain/entities/class_model.dart';

abstract class ClassDataSource{
  Future<String> addClass(ClassModel clase);
}