import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/student_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileStudentScreen extends ConsumerStatefulWidget {
  const ProfileStudentScreen({
    super.key,
    required this.student
  });

  final StudentModel student;
  static String name = "profile-student-screen";

  @override
  ProfileStudentScreenState createState() => ProfileStudentScreenState();
}


class ProfileStudentScreenState extends ConsumerState<ProfileStudentScreen> {

  int classCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    classCount = widget.student.classCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil de ${"${widget.student.name} ${widget.student.surename}"}"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    const Text("Clases disponibles", style: TextStyle(fontSize: 10)),
                    Text("$classCount", style: const TextStyle(fontSize: 20))
                  ],
                ),

                const Spacer(),
                IconButton(
                    onPressed: (){
                      setState(() {
                        if(classCount <= 0) return;
                        classCount--;
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
                        classCount++;
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
            const Spacer(),
            GestureDetector(
              onTap: () async{
                //Guardamos el class count
                OverlayLoadingView.show(context);
                //Hacemos consulta a la BD
                ref.read(studentRepositoryProvider).updateClassCount(classCount, widget.student.id);
                //Ahora hay que actualizar el provider
                ref.read(listStudentsProvider.notifier).updateClassCount(classCount, widget.student.id);
                await Future.delayed(const Duration(milliseconds: 500));
                OverlayLoadingView.hide();

                //Navegamos hacia atras
                context.pop();
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
                child: const Icon(
                  Icons.save,
                  size: 50,
                  color: Color(0xFFFFBDC4),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}
