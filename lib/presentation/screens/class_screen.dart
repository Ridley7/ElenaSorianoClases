
import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/empty_list_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
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
  @override
  Widget build(BuildContext context) {

    //Obtenemos la lista de clases
    List<ClassModel> listClass = ref.watch(listClassProvider);

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
          )
        ],
      ),
    );
  }
}

class ItemListClass extends ConsumerStatefulWidget {

  const ItemListClass({
    super.key,
    required this.clase,
  });

  final ClassModel clase;

  @override
  ItemListClassState createState() => ItemListClassState();
}

class ItemListClassState extends ConsumerState<ItemListClass> {
  @override
  Widget build(BuildContext context) {
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
              CircleAvatar(
                child: Text("${widget.clase.listStudent.length}/${widget.clase.amountStudents}"),
              ),
              const SizedBox(width: 8,),
              Text("${widget.clase.date} - ${widget.clase.hour}"),
              const Spacer(),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.copy,
                  size: 30,
                ),
              ),
              IconButton(
                  onPressed: () async{
                    OverlayLoadingView.show(context);
                    //Borramos de bd
                    await ref.read(classRepositoryProvider).deleteClass(widget.clase);
                    //Borramos de provider
                    ref.read(listClassProvider.notifier).deleteClass(widget.clase);

                    OverlayLoadingView.hide();
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
      ),
    );
  }
}
