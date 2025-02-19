
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/empty_list_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/item_list_student.dart';
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
                child: const Column(
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

