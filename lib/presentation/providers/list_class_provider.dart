import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listClassProvider = StateNotifierProvider<ListClassNotifier, List<ClassModel>>((ref){
  return ListClassNotifier();
});

class ListClassNotifier extends StateNotifier<List<ClassModel>>{
  ListClassNotifier():super([]);

  void addClass(ClassModel clase){
    state = [...state, clase];
  }

}
