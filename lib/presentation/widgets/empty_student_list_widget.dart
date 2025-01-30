import 'package:flutter/material.dart';

class EmptyStudentListWidget extends StatelessWidget {
  const EmptyStudentListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            'assets/images/de-coser.png',
            width: 200,
            height: 200,
          ),

          Text("No hay alumnos dados de alta")
        ],
      ),
    );
  }
}
