import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

          context.push('/view_class', extra: widget.clase);

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
                onPressed: () async{
                  OverlayLoadingView.show(context);

                  //Tenemos que insertar la misma clase pero con una semana despues.
                  ClassModel newClass = widget.clase.copyWith(date: addWeek(widget.clase.date));
                  //Copiamos en la bd
                  newClass.id = await ref.read(classRepositoryProvider).addClass(newClass); //AQUI ME QUEDO
                  //Copiamos en el provider
                  ref.read(listClassProvider.notifier).addClass(newClass);
                  OverlayLoadingView.hide();
                },
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

                    //Si la clase que se va a borrar ya se ha dado no tengo que sumarle nada a las alumnas

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

  String addWeek(String date){
    //Convetimos la cadena en un DateTime
    DateFormat format = DateFormat("dd/MM/yyyy");
    DateTime transformedDate = format.parse(date);

    //Sumamos 7 dias
    DateTime newDate = transformedDate.add(const Duration(days: 7));

    //Devolvemos la nueva fecha
    return format.format(newDate);
  }

}
