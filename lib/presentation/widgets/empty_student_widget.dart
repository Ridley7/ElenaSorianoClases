import 'package:elenasorianoclases/config/constants/enums.dart';
import 'package:elenasorianoclases/config/helpers/date_management.dart';
import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/domain/exceptions/app_exception.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/info_user_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/enter_class_dialog.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/snackbar_widget.dart';
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

    //QUITAR GESTURE DETECTOR
    return GestureDetector(
      onTap: (){
        EnterClassDialog.show(context, () async{
          enrollUser(context, ref);
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

  Future<void> enrollUser(BuildContext context, WidgetRef ref) async{



    OverlayLoadingView.show(context);

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

    //Comprobamos que el estudiante no este apuntado. Evitamos duplicados
    List<ClassModel> listClases = ref.read(listClassProvider);

    for(ClassModel clase in listClases){
      if(clase.id == idClase && clase.listStudent.contains(idStudent)){
        OverlayLoadingView.hide();
        snackbarWidget(context, "Ya estas apuntado");
        return;
      }
    }

    //HACER ESTE FILTRO
    //Habria que filtar aqui si es student o lecturer pero mas adelante
    if(ref.read(infoUserProvider).rol == RolType.lecturer){
      OverlayLoadingView.hide();
      snackbarWidget(context, "No puedes apuntarte. Eres la profe.");
      return;
    }

    //Comprobamos que el estudiante se pueda apuntar porque tiene clases que recuperar
    if(slotsStudent <= 0) {
      OverlayLoadingView.hide();
      snackbarWidget(context, "No puedes apuntarte. No tienes clases para recuperar");
      return;
    }

    //Comprobamos que no ha pasado el tiempo estipulado para apuntarse
    //También hay que comprobar que se pueda apuntar dentro del tiempo estipulado
    if(!DateManagement.checkTimeDifference(-30, hour, date)){
      OverlayLoadingView.hide();
      snackbarWidget(context, "El tiempo para apuntarte a esta clase ha terminado");
      return;
    }

    //Apuntamos el estudiante a la clase
    try{
      await ref.read(classRepositoryProvider).enrollStudentToClass(idClase, idStudent);
      ref.read(listClassProvider.notifier).enrollStudentToClass(idClase, idStudent);

      //Reducimos en 1 el classCount del usuario
      StudentModel studentModel = ref.read(infoUserProvider.notifier).state;
      studentModel = studentModel.copyWith(classCount: studentModel.classCount - 1);
      ref.read(infoUserProvider.notifier).state = studentModel;
    } catch (e) {
      if (e is EnrollStudentException) {
        // Manejo específico de la excepción
        //OverlayLoadingView.hide();
        snackbarWidget(context, e.message ?? "");
      } else {
        // Otros errores inesperados
        snackbarWidget(context, "Error inesperado");
      }
    }

    //Hay que hacer esta reducción también en la lista de alumnos? Lo veremos
    OverlayLoadingView.hide();


  }

}
