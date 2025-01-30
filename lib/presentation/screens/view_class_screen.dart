import 'package:elenasorianoclases/config/router/app_router.dart';
import 'package:elenasorianoclases/presentation/widgets/empty_list_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/student_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ViewClassScreen extends StatelessWidget {
  const ViewClassScreen({super.key});

  static String name = "view-class-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grupo"), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fecha: 01/02/2025", style: TextStyle(fontSize: 18)),
            Text("Hora: 17:00", style: TextStyle(fontSize: 18)),

            /*
            EmptyListWidget(
                image: "de-coser.png",
                message: "No hay alumnos apuntados en esta clase"
            ),*/


            Expanded(
              child: ListView.builder(
                itemCount: 4,
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
                          IconButton(
                              onPressed: (){},
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
            context.push("/add_student_class");
          },
        child: const Icon(
          Icons.add
        ),
      ),

    );
  }
}
