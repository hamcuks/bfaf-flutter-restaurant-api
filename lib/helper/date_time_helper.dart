import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    final timeSpecific = "08:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    //today format
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = '$todayDate $timeSpecific';
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // tomorrow format
    var formatted = resultToday.add(Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
