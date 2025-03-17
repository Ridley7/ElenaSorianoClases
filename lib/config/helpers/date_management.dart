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

    Duration difference = givenDate.difference(now);

    return difference < Duration(minutes: elapsedTime) ? false : true;
  }

}