import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/domain/exceptions/app_exception.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/messages_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/student_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:elenasorianoclases/presentation/widgets/snackbar_widget.dart';
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
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    classCount = widget.student.classCount;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.start,
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

            const SizedBox(height: 16),

            //Cuadro de texto para mensajes
            Text("Mensajes para el alumno",
              style: Theme.of(context).textTheme.titleMedium
            ),

            TextField(
              minLines: 5, // Altura fija de 5 líneas
              maxLines: 5, // No crece más, hace scroll vertical
              controller: textController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Escribe tu mensaje...',
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordes redondeados
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,

              child: FilledButton(
                  onPressed: () async {

                    if(textController.text.isEmpty) return;

                    OverlayLoadingView.show(context);

                    try{
                      //Enviamos recordatorio al alumno
                      await ref.read(messagesRepositoryProvider).addMessage(
                          widget.student.idMessages,
                          textController.text
                      );

                      textController.text = "";

                    } on DocumentExistenceException catch(e){
                      //Manejamos la excepción si el documento no existe
                      snackbarWidget(context, "Hubo un error. Mensaje no entregado");
                    }catch (e) {
                      //Manejamos cualquier otra excepción
                      snackbarWidget(context, "Error inesperado");
                    }finally{
                      //Siempre ocultamos el loading
                      OverlayLoadingView.hide();
                    }


                  },
                  child: Text("Enviar mensaje",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white
                    )
                  )
              ),
            ),

            //Aqui debemos mostrar los recordatorios que manda el profesor al alumno
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                  itemBuilder: (context, index){
                  return Text("Hola");
                  }
              ),
            ),

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
