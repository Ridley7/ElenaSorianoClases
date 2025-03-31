import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/providers/search/search_query_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredStudentProviders = Provider<List<StudentModel>>((ref){
  List<StudentModel> studentList = ref.watch(listStudentsProvider);
  String searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  //Aplicamos el filtrado
  List<StudentModel> filteredList = studentList.where((student){
    return student.name.toLowerCase().contains(searchQuery) || student.surename.toLowerCase().contains(searchQuery);
  }).toList();

  return filteredList;
});