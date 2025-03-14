import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listClassProvider = StateNotifierProvider<ListClassNotifier, List<ClassModel>>((ref){
  return ListClassNotifier();
});

class ListClassNotifier extends StateNotifier<List<ClassModel>>{
  ListClassNotifier():super([]);

  void deleteClass(ClassModel clase){
    state = state.where((c) => c.id != clase.id).toList();
  }

  void setClass(List<ClassModel> lista){
    state = List.from(lista);
  }

  void addClass(ClassModel clase){
    state = [...state, clase];
  }

  void deleteStudentToClass(String idClass, String idStudent) {
    // Creamos una nueva lista con la clase actualizada
    state = state.map((clase) {
      if (clase.id == idClass) {
        List<String> updatedList = clase.listStudent.where((id) => id != idStudent).toList();
        return clase.copyWith(listStudents: updatedList);
      }
      return clase;
    }).toList();

    state = [...state]; // Forzamos la actualización del estado
  }

  void addStudentsToClass(String idClass, List<StudentModel> students){
    //Extraemos los IDs de los estudiantes
    List<String> studentsIds = students.map((student) => student.id).toList();

    // Creamos una nueva lista con la clase actualizada
    state = state.map((clase) {
      if (clase.id == idClass) {
        List<String> updatedList = {...clase.listStudent, ...studentsIds}.toList();
        return clase.copyWith(listStudents: updatedList);
      }
      return clase;
    }).toList();
    state = [...state];
  }

  void enrollStudentToClass(String idClass, String idStudent) {
    // Obtenemos la clase
    for (ClassModel clase in state) {
      if (clase.id == idClass) {
        // Comprobamos que el estudiante no esté ya en la lista
        if (!clase.listStudent.contains(idStudent)) {
          clase.listStudent.add(idStudent);
          state = [...state]; // Actualizamos el estado solo si hubo un cambio
        }
        break;
      }
    }
  }

  void disenrollStudentToClass(String idClass, String idStudent){
    state = state.map((clase){
      if(clase.id == idClass){
        return clase.copyWith(
          listStudents: clase.listStudent.where((s) => s != idStudent).toList()
        );
      }
      return clase;
    }).toList();
  }



}
