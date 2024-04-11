
import 'dart:math';

import 'package:intl/intl.dart';

String timeStampToDateString(int milliSeconds) {
  var date = DateTime.fromMillisecondsSinceEpoch(milliSeconds);
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(date);
}
String timeStampToDayOrHourBefore(int milliSeconds) {
  DateTime currentTime = DateTime.now();
  DateTime targetTime = DateTime.fromMillisecondsSinceEpoch(milliSeconds);
  int differenceInMilliseconds = currentTime.millisecondsSinceEpoch - targetTime.millisecondsSinceEpoch;
  int differenceInMin = (differenceInMilliseconds/(1000 * 60)).round();
  int differenceInHours = (differenceInMilliseconds / (1000 * 60 * 60)).round();
  int differenceInDays = (differenceInHours / 24).round();
  if (differenceInDays > 0) {
    return '$differenceInDays天前';
  }else if(differenceInHours >0) {
    return '$differenceInHours小时前';
  }else if(differenceInMin>0){
    return '$differenceInMin分钟前';
  }else{
    return '刚刚';
  }
}
