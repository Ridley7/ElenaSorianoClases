import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
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
      locale: Locale('es', 'ES'), // Aplica el idioma aquí
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

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 16,),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: () async{
                    if(dateController.text == "--/--/---" || hourController.text == "--:--"){
                      snackbarWidget(context, "Falta la fecha o la hora");
                      return;
                    }

                    OverlayLoadingView.show(context);

                    ClassModel clase = ClassModel(
                      date: dateController.text,
                      hour: hourController.text,
                      amountStudents: amountStudents,
                      id: "",
                      listStudent: []
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
