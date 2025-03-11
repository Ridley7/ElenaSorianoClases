import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/empty_student_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/student_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  static String name = 'schedule-screen';

  @override
  ScheduleScreenState createState() => ScheduleScreenState();
}

class ScheduleScreenState extends ConsumerState<ScheduleScreen> {

  //AHORA TOCA MONTAR ESTA PANTALLA!!! QUE ES DE LAS MÁS COMPLICADAS

  DateTime focusedDay = DateTime.now();



  @override
  Widget build(BuildContext context) {

    List<ClassModel> listaClases = ref.watch(listClassProvider);
    Map<DateTime, List<ClassModel>> classMap = {};

    List<ClassModel> _getEventsForDay(DateTime day) {
      return classMap[DateTime(day.year, day.month, day.day)] ?? [];
    }

    for(var classModel in listaClases){
      //Convertimos el string date a DateTime (formato dd/mm/aaaa)
      List<String> dateParts = classModel.date.split('/');

      if(dateParts.length == 3){
        int day = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int year = int.parse(dateParts[2]);

        DateTime dateTime = DateTime(year, month, day);

        //Agregamos la clase a la lista dentro del map
        if(!classMap.containsKey(dateTime)){
          classMap[dateTime] = [];
        }

        classMap[dateTime]!.add(classModel);
      }
    }


    return Scaffold(
      appBar: AppBar(title: const Text("Horario"),),
      body: Column(
        children: [
          TableCalendar(
              focusedDay: focusedDay,
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime.utc(2035, 12, 31),
            //locale: "es_ES",
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            /*
              selectedDayPredicate: (day){
                return isSameDay(a, b)
            },
            */
            eventLoader: _getEventsForDay,

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

