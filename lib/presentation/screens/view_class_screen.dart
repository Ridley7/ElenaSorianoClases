import 'package:elenasorianoclases/config/router/app_router.dart';
import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_student_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/empty_list_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/student_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ViewClassScreen extends ConsumerStatefulWidget {
  const ViewClassScreen({super.key, required this.clase});


  final ClassModel clase;
  static String name = "view-class-screen";

  @override
  ViewClassScreenState createState() => ViewClassScreenState();
}

class ViewClassScreenState extends ConsumerState<ViewClassScreen> {
  @override
  Widget build(BuildContext context) {

    List<ClassModel> listaClases = ref.watch(listClassProvider);
    List<StudentModel> listaEstudiantes = ref.watch(listStudentsProvider);
    List<String> ids = [];
    List<StudentModel> estudiantesEncontrados = [];

    for(int i = 0; i < listaClases.length; i++){
      if(listaClases[i].id == widget.clase.id){
        ids = listaClases[i].listStudent;
        break;
      }
    }

    //Ahora extraemos los estudiantes con esos ids
    for(int i = 0; i < ids.length; i++){
      for(int j = 0; j < listaEstudiantes.length; j++){
        if(ids[i] == listaEstudiantes[j].id){
          estudiantesEncontrados.add(listaEstudiantes[j]);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Grupo"), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fecha: 01/02/2025", style: TextStyle(fontSize: 18)),
            Text("Hora: 17:00", style: TextStyle(fontSize: 18)),

            estudiantesEncontrados.isEmpty ?
            const Expanded(
              child: Row(
                children: [
                  EmptyListWidget(
                      image: "de-coser.png",
                      message: "No hay alumnos apuntados en esta clase"
                  ),
                ],
              ),
            )
            :
            Expanded(
              child: ListView.builder(
                itemCount: estudiantesEncontrados.length,
                itemBuilder: (context, index){
                  return ItemGroupClass(estudiante: estudiantesEncontrados[index]);
                }
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: (){
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save,
                          size: 50,
                        )
                      ],
                    )
                ),
              ),
            )
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
          onPressed: (){

            ///HAY QUE INDICAR EL MAXIMO NUMERO DE PERSONAS QUE SE PUEDEN APUNTAR.
            ///¿Como lo sabemos?
            context.push("/add_student_class", extra: widget.clase);
          },
        child: const Icon(
          Icons.add
        ),
      ),

    );
  }
}

class ItemGroupClass extends StatelessWidget {
  const ItemGroupClass({
    super.key, required this.estudiante,
  });
  
  final StudentModel estudiante;

  @override
  Widget build(BuildContext context) {
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
            IconButton(
                onPressed: (){
                  
                  print("Falta por implementar!!!!");
                  
                },
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                )
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
      ),
    );
  }
}
