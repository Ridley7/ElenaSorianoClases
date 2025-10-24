import 'package:elenasorianoclases/config/helpers/date_management.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/info_user_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/leave_class_dialog.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/schedule/capsule_button.dart';
import 'package:elenasorianoclases/presentation/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentWidget extends ConsumerWidget {
  const StudentWidget({
    super.key,
    required this.name,
    required this.date,
    required this.hour,
    required this.idClass
  });

  final String name;
  final String date;
  final String hour;
  final String idClass;

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    String realName = "";
    String idStudent = "";
    int classCount = 0;

    //Obtenemos el nombre real del alumno
    for(var student in ref.read(listStudentsProvider)){
      if(student.id == name){
        realName = "${student.name} ${student.surename}";
        idStudent = student.id;
        classCount = student.classCount;
      }
    }

    StudentModel studentModel = ref.read(infoUserProvider.notifier).state;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Container(
        color: const Color(0xFFFFBDC4),
        height: 60,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text(
                realName,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  fontWeight: FontWeight.bold
                )
              ),

              const Spacer(),

              studentModel.id == idStudent ?
              CapsuleButton(
                  text: "Darse de baja",
                  onPressed: () {
                    LeaveClassDialog.show(context, (){
                      unenrollUser(context, ref, idStudent, classCount);
                    });

                  }
              )
              : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> unenrollUser(BuildContext context, WidgetRef ref, String idStudent, int classCount) async{

    OverlayLoadingView.show(context);

    //Hay que comprobar que no hayan pasado 24 horas para poder desapuntarse
    //Necesita la fecha y la hora del curso
    if(!DateManagement.checkTimeDifference(1440, hour, date)){
      OverlayLoadingView.hide();
      snackbarWidget(context, "El tiempo para desapuntarte de esta clase ha expirado");
      return;
    }

    //Damos de baja al usuario en la base de datos
    await ref.read(classRepositoryProvider).disenrollStudentToClass(idClass, idStudent);
    //Quitamos al usuario de la clase
    ref.read(listClassProvider.notifier).disenrollStudentToClass(idClass, idStudent);
    //Indicamos que el usuario tiene una clase a recuperar
    final infoUserNotifier = ref.read(infoUserProvider.notifier);
    infoUserNotifier.state = infoUserNotifier.state.copyWith(classCount: classCount + 1);
    //Actualizamos el class count del estudiante en el provider
    ref.read(listStudentsProvider.notifier).updateClassCount(classCount, idStudent);

    OverlayLoadingView.hide();

  }
}

