import 'package:elenasorianoclases/presentation/widgets/decoration/input_decoration_add_student.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({super.key});

  static String name  = "add-class-screen";

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {

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
                  onPressed: (){
                    //if(nameController.text.isEmpty) return;
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
