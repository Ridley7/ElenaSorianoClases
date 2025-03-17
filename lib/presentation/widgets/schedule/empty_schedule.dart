import 'package:flutter/material.dart';

class EmptySchedule extends StatelessWidget {
  const EmptySchedule({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const SizedBox(height: 20),

        const Text(
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          "No hay clases programas para este día",
        ),

        Image.asset(
          'assets/images/not_schedule.png',
          width: 200,
          height: 200,
        ),
      ],
    );
  }
}


