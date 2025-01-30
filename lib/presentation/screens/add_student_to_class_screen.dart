import 'package:flutter/material.dart';

class AddStudentToClassScreen extends StatefulWidget {
  const AddStudentToClassScreen({super.key});

  static String name = "add-student-to-class";

  @override
  State<AddStudentToClassScreen> createState() => _AddStudentToClassScreenState();
}

class _AddStudentToClassScreenState extends State<AddStudentToClassScreen> {

  Map<int, bool> checkedItems = {}; // Para manejar el estado de los checkboxes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de alumnos"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20,
                itemBuilder: (context, index){
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
                          const CircleAvatar(
                            child: const Text("T"),
                          ),
                          const SizedBox(width: 8,),
                          const Text("Maria Alejandra Zarate"),
                          const Spacer(),
                          Checkbox(
                            value: checkedItems[index] ?? false, // Estado del checkbox
                            onChanged: (bool? value) {
                              setState(() {
                                checkedItems[index] = value ?? false;
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
                onPressed: (){},
                child: const Text("Agregar")
            ),
          )

        ],
      )
    );
  }
}
