import 'package:elenasorianoclases/domain/entities/student_model.dart';
import 'package:elenasorianoclases/presentation/providers/firebase/class_repository_provider.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/loaders/overlay_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemGroupClass extends ConsumerWidget {
  const ItemGroupClass({
    super.key,
    required this.estudiante,
    required this.idClass
  });

  final StudentModel estudiante;
  final String idClass;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onPressed: () async {
                  OverlayLoadingView.show(context);
                  //Borramos el estudiante de la base de datos
                  await ref.read(classRepositoryProvider).deleteStudentToClass(idClass, estudiante.id);

                  //Borramos el estudiante de memoria
                  ref.read(listClassProvider.notifier).deleteStudentToClass(idClass, estudiante.id);
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
    );
  }
}
