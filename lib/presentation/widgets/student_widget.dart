import 'package:elenasorianoclases/presentation/widgets/leave_class_dialog.dart';
import 'package:flutter/material.dart';

class StudentWidget extends StatelessWidget {
  const StudentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        LeaveClassDialog.show(context, (){});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          color: const Color(0xFFFFBDC4),
          height: 60,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: const Text(
            "Maria Fernanda Cabal",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black54
            ),
          ),
        ),
      ),
    );
  }
}
