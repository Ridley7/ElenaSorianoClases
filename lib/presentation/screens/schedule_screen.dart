import 'package:elenasorianoclases/domain/entities/class_model.dart';
import 'package:elenasorianoclases/presentation/providers/list_class_provider.dart';
import 'package:elenasorianoclases/presentation/widgets/empty_student_widget.dart';
import 'package:elenasorianoclases/presentation/widgets/schedule/enrolled_students.dart';
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

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

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
              focusedDay: _focusedDay,
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime.utc(2035, 12, 31),
            //locale: "es_ES",
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,

              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },

            onDaySelected: (selectedDay, focusedDay){
              if(!isSameDay(_selectedDay, selectedDay)){
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;

                  /*
                void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _selectedEvents.value = _getEventsForDay(selectedDay);
                    });
                  }
                }
                 */

                });
              }
            },

            eventLoader: _getEventsForDay,
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
              weekendTextStyle: TextStyle(color: Colors.pink),
              holidayTextStyle: TextStyle(color: Colors.pink),
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false
            ),
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, _){
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                  color: Colors.yellow,
                  width: 100,
                  height: 100,
                  child: Text(
                    "${date.day}",
                    style: const TextStyle().copyWith(fontSize: 16.0),
                  ),
                );
              },

              todayBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                  color: Colors.teal,
                  width: 100,
                  height: 100,
                  child: Text(
                    "${date.day}",
                    style: const TextStyle()
                        .copyWith(fontSize: 16.0, color: Colors.white),
                  ),
                );
              },
                /*
              prioritizedBuilder: (context, date, _){
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.zero,
                      color: Colors.red,
                      border: Border.all(
                          color: Colors.black,
                          width: 2.0
                      )
                  ),
                  child: Center(
                    child: Text(
                      "${date.day}",
                      style: TextStyle().copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                );
              }
              */
            ),

          ),

          const SizedBox(height: 8.0,),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Row(
                    children: [
                      const Spacer(),
                      Text("${_getEventsForDay(_selectedDay).length} Clases")
                    ],
                  ),


                  ListView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _getEventsForDay(_selectedDay).length,
                      itemBuilder: (context, index){

                      List<ClassModel> clasesDelDia = _getEventsForDay(_selectedDay);

                      return Column(
                        children: [
                          //Contenido

                          Row(
                            children: [
                              Text("${index + 1}. Clase"),
                              const Spacer(),
                              Text(clasesDelDia[index].hour)
                            ],
                          ),

                          const Row(
                            children: [
                              Text("Asistentes: ")
                            ],
                          ),

                          EnrolledStudents(clase: clasesDelDia[index]),

                        ],
                      );
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


