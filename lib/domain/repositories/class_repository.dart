import 'package:elenasorianoclases/domain/entities/class_model.dart';

abstract class ClassRepository{
  Future<String> addClass(ClassModel clase);
}