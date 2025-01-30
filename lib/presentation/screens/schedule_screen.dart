import 'package:elenasorianoclases/presentation/widgets/empty_student_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/student_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  static String name = 'schedule-screen';

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  DateTime focusedDay = DateTime.utc(2023, 12, 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Horario"),),
      body: Column(
        children: [
          TableCalendar(
              focusedDay: focusedDay,
            firstDay: DateTime.utc(2023, 9, 1),
            lastDay: DateTime.utc(2024, 1, 30),
          ),

          const SizedBox(height: 8.0,),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Contenido
                  const Row(
                    children: [
                      Spacer(),
                      Text("2 Clases")
                    ],
                  ),
            
                  const Row(
                    children: [
                      Text("1. Clase"),
                      Spacer(),
                      Text("17:00 - 18:45")
                    ],
                  ),
            
                  const Row(
                    children: [
                      Text("Asistentes:")
                    ],
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index){
                        return EmptyStudentWidget();
                      }
                  ),
            

                  const Row(
                    children: [
                      Text("2. Clase"),
                      Spacer(),
                      Text("19:00 - 20:45")
                    ],
                  ),

                  const Row(
                    children: [
                      Text("Asistentes:")
                    ],
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index){
                        return StudentWidget();
                      }
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

