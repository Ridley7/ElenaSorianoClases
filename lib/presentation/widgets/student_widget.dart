import 'package:elenasorianoclases/config/helpers/date_management.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/info_user_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/general_dialog.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/schedule/capsule_button.dart';
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
                    unenrollUser(context, ref, idStudent, classCount);
                  }
              )
              : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> unenrollUser(
      BuildContext context,
      WidgetRef ref,
      String idStudent,
      int classCount,
      ) async {
    // Primera confirmación
    final bool? confirmLeave = await GeneralDialog.show(
      context,
      message: "Atención. Va a abandonar esta clase.",
    );

    if (confirmLeave != true) return;

    // Comprobamos si quedan menos de 24 horas
    final bool lessThan24Hours = !DateManagement.checkTimeDifference(1440, hour, date);

    // Si quedan menos de 24 horas, segunda confirmación
    if (lessThan24Hours) {
      final bool? confirmNoRecovery = await GeneralDialog.show(
        context,
        message:
        "Quedan menos de 24 horas para el inicio de la clase. "
            "Puede darse de baja de la clase, pero esta NO será recuperable. "
            "¿Desea darse de baja?",
      );

      if (confirmNoRecovery != true) return;
    }

    OverlayLoadingView.show(context);

    try {
      // Damos de baja al usuario en la base de datos
      await ref.read(classRepositoryProvider).disenrollStudentToClass(idClass, idStudent, !lessThan24Hours);

      // Actualizamos el listado local de clases
      ref.read(listClassProvider.notifier).disenrollStudentToClass(idClass, idStudent,);

      // Si quedan 24 horas o más, la clase es recuperable
      if (!lessThan24Hours) {
        final infoUserNotifier = ref.read(infoUserProvider.notifier);

        infoUserNotifier.state = infoUserNotifier.state.copyWith(
          classCount: classCount + 1,
        );

        ref
            .read(listStudentsProvider.notifier)
            .updateClassCount(
          classCount + 1,
          idStudent,
        );
      }
    } finally {
      OverlayLoadingView.hide();
    }
  }
}

