import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/decoration/input_decoration_add_student.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddClassScreen extends ConsumerStatefulWidget {
  const AddClassScreen({super.key});

  static String name  = "add-class-screen";

  @override
  AddClassScreenState createState() => AddClassScreenState();
}

class AddClassScreenState extends ConsumerState<AddClassScreen> {

  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController(text: "--/--/----");

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }

  TimeOfDay? selectedTime;
  final TextEditingController hourController = TextEditingController(text: "--:--");

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        hourController.text = selectedTime!.format(context);
      });
    }
  }

  int amountStudents = 4;
  //Lista para los checkbox seleccionados
  List<bool> selectedStudents = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final listStudents = ref.watch(listStudentsProvider);

    // Inicializar solo la primera vez (si la lista cambió de tamaño)
    if (selectedStudents.length != listStudents.length) {
      selectedStudents = List.filled(listStudents.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {

    List<StudentModel> listStudents = ref.watch(listStudentsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Añadir clase"), centerTitle: true),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),

            TextFormField(
              controller: dateController,
              readOnly: true,
              decoration: inputDecorationAddStudent(labelText: "Fecha"),
              onTap: (){
                _selectDate(context);
              },
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: hourController,
              readOnly: true,
              decoration: inputDecorationAddStudent(labelText: "Hora"),
              onTap: (){
                _selectTime(context);
              },
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Column(
                  children: [
                    const Text("Cantidad de alumnos", style: TextStyle(fontSize: 10),),
                    Text("$amountStudents", style: const TextStyle(fontSize: 20),)
                  ],
                ),

                const Spacer(),

                IconButton(
                    onPressed: (){
                      setState(() {
                        amountStudents--;
                      });
                    },
                    icon: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: const Color(0xFFFFBDC4)
                          )
                      ),
                      child: const Icon(
                          Icons.exposure_minus_1
                      ),
                    )
                ),

                IconButton(
                    onPressed: (){
                      setState(() {
                        amountStudents++;
                      });
                    },
                    icon: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: const Color(0xFFFFBDC4)
                        )
                      ),
                      child: const Icon(
                        Icons.plus_one
                      ),
                    )
                ),
              ],
            ),

            //Lista de alumnos
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listStudents.length,
                itemBuilder: (context, index){
                  StudentModel student = listStudents[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
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
                            child: Text(student.name[0].toUpperCase()),
                          ),
                          const SizedBox(width: 8,),
                          Text("${student.name} ${student.surename}"),

                          const Spacer(),

                          Checkbox(
                            value: selectedStudents[index],
                            onChanged: (bool? value) {
                              setState(() {
                                selectedStudents[index] = value ?? false;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  );
                },
              ),
            ),


            const SizedBox(height: 16,),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: () async{

                    //Hay que comprobar que no se puedan elegir mas alumnos de los que
                    //estan permitidos
                    if(selectedStudents.where((isSelected) => isSelected).length > amountStudents){
                      snackbarWidget(context, "Has seleccionado mas alumnos de los permitidos");
                      return;
                    }

                    if(dateController.text == "--/--/---" || hourController.text == "--:--"){
                      snackbarWidget(context, "Falta la fecha o la hora");
                      return;
                    }

                    OverlayLoadingView.show(context);

                    //Obtenemos los ids de los estudiantes seleccionados
                    List<String> selectedStudentIds = [];
                    for(int i = 0; i < selectedStudents.length; i++){
                      if(selectedStudents[i]){
                        selectedStudentIds.add(listStudents[i].id);
                      }
                    }

                    ClassModel clase = ClassModel(
                      date: dateController.text,
                      hour: hourController.text,
                      amountStudents: amountStudents,
                      id: "",
                      listStudent: selectedStudentIds
                    );

                    //Guardamos clase en base de datos
                    clase.id = await ref.read(classRepositoryProvider).addClass(clase);

                    //Añadimos la clase al provider
                    ref.read(listClassProvider.notifier).addClass(clase);

                    snackbarWidget(context, "Clase creada correctamente");

                    dateController.text = "--/--/----";
                    hourController.text = "--:--";

                    OverlayLoadingView.hide();

                  },
                  child: const Text("Añadir clase",)
              ),
            )
          ],
        ),
      ),
    );
  }
}
