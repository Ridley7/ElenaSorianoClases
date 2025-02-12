import 'package:elenasorianoclases/domain/entities/class_model.dart';
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

}
