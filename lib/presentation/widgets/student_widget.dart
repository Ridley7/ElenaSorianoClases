import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/info_user_provider.dart';
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
    String idStudent = "";

    //Obtenemos el nombre real del alumno
    for(var student in ref.read(listStudentsProvider)){
      if(student.id == name){
        realName = "${student.name} ${student.surename}";
        idStudent = student.id;
      }
    }

    StudentModel studentModel = ref.read(infoUserProvider.notifier).state;
    print(studentModel.name);
    print(studentModel.id);
    print(idStudent);


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
          child: Row(
            children: [
              Text(
                realName,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54
                )
              ),

              const Spacer(),

              studentModel.id == idStudent ?
              CapsuleButton(text: "Darse de baja", onPressed: (){})
              : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}


class CapsuleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const CapsuleButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.pink,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordes redondeados
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Espaciado interno
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

