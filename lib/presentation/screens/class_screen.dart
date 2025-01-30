
import 'package:elenasorianoclases/presentation/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({super.key});

  static String name = "class-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clases"), centerTitle: true),
      body: Column(
        children: [
          //EmptyListWidget(image: "conferencia.png", message: "No hay clases creadas",),
          Expanded(
            child: ListView.builder(
              itemCount: 40,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  child: InkWell(
                    onTap: (){
                      context.push('/view_class');
                    },
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
                            child: const Text("0/4"),
                          ),
                          const SizedBox(width: 8,),
                          const Text("12/02/2025 - 17:00"),
                          const Spacer(),
                          IconButton(
                            onPressed: (){},
                            icon: const Icon(
                              Icons.copy,
                              size: 30,
                            ),
                          ),
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
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 2,),

          //Boton para añadir estudiantes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: (){
                context.push("/add_class");
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
                        Icons.add_circle,
                        size: 50,
                      )
                    ],
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
