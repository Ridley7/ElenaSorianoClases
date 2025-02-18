import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listStudentsProvider = StateNotifierProvider<ListStudentNotifier, List<StudentModel>>((ref){
  return ListStudentNotifier();
});

class ListStudentNotifier extends StateNotifier<List<StudentModel>>{
  ListStudentNotifier():super([]);

  void init(List<StudentModel> estudiantes){
    state = [...estudiantes];
  }
}