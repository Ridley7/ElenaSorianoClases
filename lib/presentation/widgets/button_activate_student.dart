import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/student_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonActivateStudent extends ConsumerStatefulWidget {
  const ButtonActivateStudent({
    super.key,
    required this.estudiante,
  });

  final StudentModel estudiante;

  @override
  ButtonActivateStudentState createState() => ButtonActivateStudentState();
}

class ButtonActivateStudentState extends ConsumerState<ButtonActivateStudent> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    if(isLoading) return const CircularProgressIndicator();

    return IconButton(
      onPressed: () async {

        setState(() {
          isLoading = true;
        });

        //Hacemos el cambio en base de datos
        await ref.read(studentRepositoryProvider).setAccess(!widget.estudiante.access, widget.estudiante.id);
        //Hacemos el cambio en el provider
        ref.read(listStudentsProvider.notifier).setAccessStudent(!widget.estudiante.access, widget.estudiante.id);

        setState(() {
          isLoading = false;
        });

      },
      icon: Icon(
        Icons.online_prediction,
        size: 30,
        color: widget.estudiante.access ? Colors.green : Colors.red,
      ),
    );
  }
}
