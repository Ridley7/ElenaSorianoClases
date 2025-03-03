import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddStudentToClassScreen extends ConsumerStatefulWidget {
  const AddStudentToClassScreen({
    super.key,
    required this.clase
  });

  static String name = "add-student-to-class";
  final ClassModel clase;

  @override
  AddStudentToClassScreenState createState() => AddStudentToClassScreenState();
}

class AddStudentToClassScreenState extends ConsumerState<AddStudentToClassScreen> {

  Map<int, bool> checkedItems = {}; // Para manejar el estado de los checkboxes

  @override
  Widget build(BuildContext context) {

    List<StudentModel> listaEstudiantes = ref.watch(listStudentsProvider).where((estudiante) => widget.clase.listStudent.contains(estudiante.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Lista de alumnos"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listaEstudiantes.length,
                itemBuilder: (context, index){

                StudentModel estudiante = listaEstudiantes[index];

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
                            child: Text(estudiante.name[0]),
                          ),
                          const SizedBox(width: 8,),
                          Text("${estudiante.name} ${estudiante.surename}"),
                          const Spacer(),
                          Checkbox(
                            value: checkedItems[index] ?? false, // Estado del checkbox
                            onChanged: (bool? value) {
                              setState(() {
                                checkedItems = Map.from(checkedItems)
                                ..[index] = value ?? false;

                              });
                            },
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),


          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
                onPressed: (){
                  // Filtramos solo los estudiantes seleccionados
                  final List<StudentModel> selectedStudents = listaEstudiantes
                      .asMap()
                      .entries
                      .where((entry) => checkedItems[entry.key] == true)
                      .map((entry) => entry.value)
                      .toList();

                  final int remainingStudents = widget.clase.amountStudents - widget.clase.listStudent.length;

                  if(selectedStudents.length >= remainingStudents){
                    snackbarWidget(context, "Son demasiados estudiantes para esa clase");
                    return;
                  }



                  //Ahora guardamos la lista de estudiantes en la bd




                },
                child: const Text("Agregar")
            ),
          )

        ],
      )
    );
  }
}
