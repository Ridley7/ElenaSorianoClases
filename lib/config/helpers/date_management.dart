import 'package:intl/intl.dart';

class DateManagement{

  static bool checkTimeDifference(int elapsedTime, String hour, String date) {

    DateTime now = DateTime.now();
    DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
    DateTime parsedTime = DateFormat("HH:mm").parse(hour);

    DateTime givenDate = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        parsedTime.hour,
        parsedTime.minute
    );

    print("La fecha de la calse es $givenDate");

    Duration difference = givenDate.difference(now);

    print("La fecha now es: $now");
    print("La diferencia es: $difference");

    return difference < Duration(minutes: elapsedTime) ? false : true;
  }

}