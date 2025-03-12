import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/leave_class_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentWidget extends ConsumerWidget {
  const StudentWidget({
    super.key,
    required this.name
  });

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    String realName = "";

    //Obtenemos el nombre real del alumno
    for(var student in ref.read(listStudentsProvider)){
      if(student.id == name){
        realName = "${student.name} ${student.surename}";
      }
    }

    return GestureDetector(
      onTap: (){
        LeaveClassDialog.show(context, (){});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          color: const Color(0xFFFFBDC4),
          height: 60,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Text(
            realName,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.black54
            ),
          ),
        ),
      ),
    );
  }
}
