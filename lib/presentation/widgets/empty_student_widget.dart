import 'package:elenasorianoclases/presentation/widgets/enter_class_dialog.dart';
import 'package:elenasorianoclases/presentation/widgets/leave_class_dialog.dart';
import 'package:flutter/material.dart';

class EmptyStudentWidget extends StatelessWidget {
  const EmptyStudentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        EnterClassDialog.show(context, (){});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          color: Colors.grey,
          height: 60,
          width: double.infinity,
          child: const Icon(
                  Icons.add_circle,
                  size: 50,
                color: Colors.white,

          )
          ),
        ),
      );
  }
}
