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

  void deleteStudent(String id){
    state = state.where((student) => student.id != id).toList();
  }

  void setAccessStudent(bool access, String id) {
    state = state.map((student) {
      if (student.id == id) {
        return student.copyWith(access: access); // Actualiza solo el campo 'access'
      }
      return student;
    }).toList();
  }

  void updateClassCount(int classCount, String id){
    state = state.map((student){
      if(student.id == id){
        return student.copyWith(classCount: classCount);
      }
      return student;
    }).toList();
  }

}