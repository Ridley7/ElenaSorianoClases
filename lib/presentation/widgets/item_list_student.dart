import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/student_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/button_activate_student.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/shared/generic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ItemListStudent extends ConsumerWidget {
  const ItemListStudent({
    super.key,
    required this.estudiante,
  });

  final StudentModel estudiante;

  //AQUI ME QUEDO. HE DE PONER ALGUNA FORMA DE INCREMENTAR O DECREMENTAR EL CLASS COUNT DE LOS ESTUDIANTES

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: (){

        context.push('/profile_student', extra: estudiante);

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color(0xFFFFBDC4),
                  width: 1
              )
          ),
          child: Row(
            children: [
              const SizedBox(width: 8,),
              CircleAvatar(
                child: Text(estudiante.name[0].toUpperCase()),
              ),
              const SizedBox(width: 8,),
              Text("${estudiante.name} ${estudiante.surename}"),
              const Spacer(),

              ButtonActivateStudent(estudiante: estudiante),

              IconButton(
                  onPressed: () {
                    //Aqui necesito cuadro de dialogo
                    GenericDialog.show(
                        context,
                        "¿Eliminar permanentemente?",
                        "Estas apunto de eliminar a ${estudiante.name} ${estudiante.surename} ",
                            () => _confirmDelete(context, ref)
                    );

                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 30,
                  )
              ),
              const SizedBox(
                width: 8,
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Función para confirmar y eliminar estudiante
  void _confirmDelete(BuildContext context, WidgetRef ref) {
    GenericDialog.show(
      context,
      "¿Eliminar permanentemente?",
      "Estás a punto de eliminar a ${estudiante.name} ${estudiante.surename}.",
          () async {
        await _deleteStudent(context, ref);
      },
    );
  }

  /// Función que maneja la eliminación del estudiante
  Future<void> _deleteStudent(BuildContext context, WidgetRef ref) async {
    try {
      OverlayLoadingView.show(context);

      // Borrar estudiante de la base de datos
      await ref.read(studentRepositoryProvider).deleteStudent(estudiante.id);

      // Borrar estudiante del provider
      ref.read(listStudentsProvider.notifier).deleteStudent(estudiante.id);
    } catch (e) {
      // Puedes manejar errores aquí si lo deseas
      print("Error eliminando estudiante: $e");
    } finally {
      OverlayLoadingView.hide();
    }
  }
}


