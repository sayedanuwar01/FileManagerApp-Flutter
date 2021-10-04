
import 'package:intl/intl.dart';

class TimeUtil {

  static String time_util_type = "yyyy-MM-dd HH:mm:ss";
  static String time_code_spain = "en_US";
  static String time_util_birthday = "dd/MM/yyyy";

  static String getDelayTime(String time, String type){

    DateTime parsed_current_date = DateTime.parse(getCurrentTime());
    DateTime parsed_received_date = DateTime.parse(time);

    int diff = parsed_current_date.difference(parsed_received_date).inSeconds;

    if(diff > 2592000){
      int day = (diff / (3600 * 24 * 30)).toInt();
      return day.toString() == 1? day.toString() + "month ago" : day.toString() + "months ago";
    }else if (diff > 3600 * 24) {
      int day = (diff / (3600 * 24)).toInt();
      return day.toString() + "d ago";
    } else if (diff > 3600) {
      int hour = (diff / 3600).toInt();
      return hour.toString() + "h ago";
    } else if (diff > 60) {
      int min = (diff / 60).toInt();
      return min.toString() + "m ago";
    } else {
      return "Just";
    }
  }

  static String getCurrentTime(){
    final now = DateTime.now();
    final formatter = DateFormat(time_util_type, time_code_spain);
    return formatter.format(now);
  }

  static String getBirthdayFormatted(DateTime selectedDate){
    final formatter = DateFormat(time_util_birthday);
    return formatter.format(selectedDate);
  }

  static String getTimeStamp(){
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static DateTime getDateFromString(String _date){
    DateFormat format = DateFormat(time_util_birthday);
    return format.parse(_date);
  }
}