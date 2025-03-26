import 'package:elenasorianoclases/config/constants/enums.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/student_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/decoration/input_decoration_add_student.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddStudentScreen extends ConsumerWidget {
  const AddStudentScreen({super.key});

  static String name = "add-student-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final TextEditingController nameController = TextEditingController();
    final TextEditingController surenameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Añadir Estudiante"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),

            TextFormField(
              controller: nameController,
              decoration: inputDecorationAddStudent(labelText: "Nombre"),
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: surenameController,
              decoration: inputDecorationAddStudent(labelText: "Apellido"),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: () async {
                    if(nameController.text.isEmpty){
                      snackbarWidget(context, "El nombre es obligatorio");
                      return;
                    }

                    if(surenameController.text.isEmpty){
                      snackbarWidget(context, "El apellido es obligatorio");
                      return;
                    }

                    OverlayLoadingView.show(context);

                    //Creamos un estudiante
                    StudentModel newStudent = StudentModel(
                        id: "",
                        uid: "",
                        name: nameController.text,
                        surename: surenameController.text,
                        access: true,
                        rol: RolType.student,
                        classCount: 0
                    );

                    //Hacemos la inserción en la base de datos
                    String newId = await ref.read(studentRepositoryProvider).addStudent(newStudent);
                    newStudent.id = newId;

                    //Hacemos la inserción en memoria
                    ref.read(listStudentsProvider.notifier).addNewStudent(newStudent);

                    OverlayLoadingView.hide();

                    context.pop();

                  },
                  child: const Text("Añadir estudiante",)
              ),
            )

          ],
        ),
      ),
    );
  }
}
