/// Returns the current date and time as 'YYYY-MM-DD'
String now() {
  final now = DateTime.now();
  String mothString="";
  String dayString = "";
  if(now.month >= 10){
    mothString = now.month.toString();
  }else{
    mothString = '0${now.month.toString()}';
  }
  if(now.day  >= 10){
    dayString = now.day.toString();
  }else{
    dayString = '0${now.day.toString()}';
  }
  return '${now.year}-$mothString-$dayString';
}
String nowString(){
  final now = DateTime.now();
  String mothString="";
  String dayString = "";
  String hourString='';
  String minuteString ='';
  String secondString ='';
  if(now.month >= 10){
    mothString = now.month.toString();
  }else{
    mothString = '0${now.month.toString()}';
  }
  if(now.day  >= 10){
    dayString = now.day.toString();
  }else{
    dayString = '0${now.day.toString()}';
  }
  if(now.hour>=10){
    hourString = now.hour.toString();
  }else{
    hourString = '0${now.hour.toString()}';
  }
  if(now.minute>=10){
    minuteString = now.minute.toString();
  }else{
    minuteString = '0${now.minute.toString()}';
  }
  if(now.second >=10){
    secondString = now.second.toString();
  }else{
    secondString = '0${now.second.toString()}';
  }

  return '${now.year}$mothString$dayString$hourString$minuteString$secondString';
}

String get currentYear => DateTime.now().year.toString();

String get currentMonth => DateTime.now().month.toString();

String get currentDay => DateTime.now().day.toString();
int get currentHourInt => DateTime.now().hour;


/// 生成未來count天的DateTime對象，包括今天
List<DateTime> generateNextDateTimes(int count) {
  final now = DateTime.now();
  final nextDayTimes = <DateTime>[];
  for (var i = 0; i < count; i++) {
    final nextDay = now.add(Duration(days: i));
    nextDayTimes.add(nextDay);
  }
  return nextDayTimes;
}

/// 返回count天后的日期
DateTime theDateAfter(int days) {
  final now = DateTime.now();
  return now.add(Duration(days: days));
}
/// 返回count天前的日期
DateTime theDateBefore(int days){
  final now = DateTime.now();
  return now.subtract(Duration(days: days));

}

/// dateTime 轉成 'YYYY-MM-DD'
String dateTimeToString(DateTime dateTime) {
  return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
}
