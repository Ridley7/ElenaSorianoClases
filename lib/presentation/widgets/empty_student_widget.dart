import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/enter_class_dialog.dart';
import 'package:elenasorianoclases/presentation/widgets/leave_class_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyStudentWidget extends ConsumerWidget {
  const EmptyStudentWidget({
    super.key,
    required this.idClase,
    required this.date,
    required this.hour
  });

  final String idClase;
  final String date;
  final String hour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: (){
        EnterClassDialog.show(context, () async{

          //Obtenemos el id del usuario
          String uid = FirebaseAuth.instance.currentUser!.uid;
          String idStudent = "";

          for(var student in ref.read(listStudentsProvider)){
            if(student.uid == uid){
              idStudent = student.id;
              break;
            }
          }

          //También necesitamos comprobar que el estudiante se pueda apuntar
          //porque tiene clases que recuperar

          //También hay que comprobar que se pueda apuntar dentro del tiempo estipulado

          //Apuntamos al estudiante a la clase
          await ref.read(classRepositoryProvider).enrollStudentToClass(idClase, idStudent);

          //AQUI ME QUEDO HAY QUE MODIFICAR LA MEMORIA O MAS BIEN EL PROVIDER QUE ESTA EN LA MEMORIA

        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          color: Colors.grey,
          height: 60,
          width: double.infinity,
          child: const Icon(
                  Icons.add_circle,
                  size: 50,
                color: Colors.white,

          )
          ),
        ),
      );
  }
}
