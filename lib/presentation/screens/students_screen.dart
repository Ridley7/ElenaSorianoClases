
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/student_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/empty_list_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StudentsScreen extends ConsumerStatefulWidget {
  const StudentsScreen({super.key});

  static String name = "students-screen";

  @override
  StudentsScreenState createState() => StudentsScreenState();
}

class StudentsScreenState extends ConsumerState<StudentsScreen> {
  @override
  Widget build(BuildContext context) {

    List<StudentModel> listaEstudiantes = ref.watch(listStudentsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Estudiantes"), centerTitle: true),
      body: Column(
        children: [
          listaEstudiantes.isEmpty
          ? const EmptyListWidget(image: "de-coser.png", message: "No hay alumnos dados de alta",)
          : Expanded(
            child: ListView.builder(
              itemCount: listaEstudiantes.length,
              itemBuilder: (context, index){

                StudentModel estudiante = listaEstudiantes[index];

                return ItemListStudent(estudiante: estudiante);
              },
            ),
          ),


          const SizedBox(height: 2,),

          //Boton para añadir estudiantes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: (){
                context.push("/add_student");
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFFBDC4),
                    width: 3
                  )
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle,
                      size: 50,
                      color: const Color(0xFFFFBDC4),
                    )
                  ],
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemListStudent extends ConsumerWidget {
  const ItemListStudent({
    super.key,
    required this.estudiante,
  });

  final StudentModel estudiante;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
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
            IconButton(
                onPressed: () async {
                  //Aqui hay que borrar al estudiante, e incluso quitarlo de las credenciales
                  OverlayLoadingView.show(context);
                  //Borramos estudiante de la BD
                  await ref.read(studentRepositoryProvider).deleteStudent(estudiante.id);
                  //Borramos estudiante del provider
                  ref.read(listStudentsProvider.notifier).deleteStudent(estudiante.id);
                  OverlayLoadingView.hide();
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
    );
  }
}

