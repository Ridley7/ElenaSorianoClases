import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final infoUserProvider = StateProvider<StudentModel>((ref) => StudentModel.empty());