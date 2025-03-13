import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/info_user_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/enter_class_dialog.dart';
import 'package:elenasorianoclases/presentation/widgets/leave_class_dialog.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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

    bool checkTimeDifference() {
      DateTime now = DateTime.now();
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
      DateTime parsedTime = DateFormat("HH:mm").parse(hour);

      DateTime givenDate = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        parsedTime.hour,
        parsedTime.minute
      );

      Duration difference = givenDate.difference(now);

      return difference < const Duration(minutes: -30) ? false : false;
    }


    return GestureDetector(
      onTap: (){
        EnterClassDialog.show(context, () async{

          //Obtenemos el id del usuario
          String uid = FirebaseAuth.instance.currentUser!.uid;
          String idStudent = "";
          int slotsStudent = 0;

          for(var student in ref.read(listStudentsProvider)){
            if(student.uid == uid){
              idStudent = student.id;
              slotsStudent = student.classCount;
              break;
            }
          }

          //Habria que filtar aqui si es student o lecturer pero mas adelante

          //Comprobamos que el estudiante se pueda apuntar porque tiene clases que recuperar
          if(slotsStudent <= 0) {
            OverlayLoadingView.hide();
            snackbarWidget(context, "No puedes apuntarte. No tienes clases para recuperar");
            return;
          }

          //Comprobamos que no ha pasado el tiempo estipulado para apuntarse
          //También hay que comprobar que se pueda apuntar dentro del tiempo estipulado
          if(!checkTimeDifference()){
            OverlayLoadingView.hide();
            snackbarWidget(context, "El tiempo para apuntarte a esta clase ha terminado");
            return;
          }

          //Apuntamos el estudiante a la clase
          await ref.read(classRepositoryProvider).enrollStudentToClass(idClase, idStudent);
          ref.read(listClassProvider.notifier).enrollStudentToClass(idClase, idStudent);

          //Reducimos en 1 el classCount del usuario
          StudentModel studentModel = ref.read(infoUserProvider.notifier).state;
          studentModel = studentModel.copyWith(classCount: studentModel.classCount - 1);
          ref.read(infoUserProvider.notifier).state = studentModel;

          //Hay que hacer esta reducción también en la lista de alumnos? Lo veremos


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
