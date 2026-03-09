
import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/empty_list_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/item_list_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ClassScreen extends ConsumerStatefulWidget {
  const ClassScreen({super.key});

  static String name = "class-screen";

  @override
  ClassScreenState createState() => ClassScreenState();
}



class ClassScreenState extends ConsumerState<ClassScreen> {

  List<ClassModel> listClass = [];
  bool downloading = true;

  @override
  void initState() {

    downloadClass();
    super.initState();
  }

  Future<void> downloadClass() async {
    listClass = await ref.read(classRepositoryProvider).getAllClass();
    ref.read(listClassProvider.notifier).setClass(listClass);
    setState(() {
      downloading = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    //Obtenemos la lista de clases
    listClass = ref.watch(listClassProvider);

    if(downloading){
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Clases"), centerTitle: true),
      body: Column(
        children: [
          listClass.isEmpty
          ? const EmptyListWidget(image: "conferencia.png", message: "No hay clases creadas",)
          : Expanded(
            child: ListView.builder(
              itemCount: listClass.length,
              itemBuilder: (context, index){
                return ItemListClass(clase: listClass[index]);
              },
            ),
          ),

          const SizedBox(height: 2,),

          //Boton para añadir estudiantes
          SafeArea(
            child: Padding(
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
                    child: const Column(
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
            ),
          )
        ],
      ),
    );
  }
}

