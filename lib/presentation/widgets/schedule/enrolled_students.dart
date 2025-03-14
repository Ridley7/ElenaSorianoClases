import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/presentation/widgets/empty_student_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/student_widget.dart';
import 'package:flutter/material.dart';

class EnrolledStudents extends StatelessWidget {
  const EnrolledStudents({
    super.key,
    required this.clase
  });

  final ClassModel clase;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: clase.amountStudents,
        itemBuilder: (context, subIndex){

          //Validamos si el indice existe en la lista
          if(subIndex < clase.listStudent.length){
            return StudentWidget(
                name: clase.listStudent[subIndex],
              hour: clase.hour,
              date: clase.date,
              idClass: clase.id,
            );
          }else{
            return EmptyStudentWidget(
                idClase: clase.id,
              date: clase.date,
              hour: clase.hour,
            );
          }
        }
    );
  }
}
