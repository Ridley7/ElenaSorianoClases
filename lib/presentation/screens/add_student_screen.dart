import 'package:elenasorianoclases/presentation/widgets/decoration/input_decoration_add_student.dart';
import 'package:flutter/material.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  static String name = "add-student-screen";

  @override
  Widget build(BuildContext context) {

    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Añadir Estudiante"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),

            TextFormField(
              controller: nameController,
              decoration: inputDecorationAddStudent(),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: (){
                    if(nameController.text.isEmpty) return;
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
