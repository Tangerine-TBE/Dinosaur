import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';

class MothItem {
  final DateTime currentDateTime;
  final List<RangeItem> rangItems = <RangeItem>[];
  List<DateTime> calOvulationDates = [];
  List<DateTimeRange> aboutTheCalOvulationDateRange = [];

  MothItem({required this.currentDateTime});

  addRangItem(RangeItem rangeItem, List<MothItem> list) {
    rangItems.add(rangeItem);
    DateTime maxDate = DateTime(1990, 1, 1);
    for (var i in rangItems) {
      if (i.selectedStartDate.isAfter(maxDate)) {
        maxDate = i.selectedStartDate;
      }
    }
    for(int i = 0 ; i < list.length ; i ++){
      list[i].calOvulationDates.clear();
      list[i].aboutTheCalOvulationDateRange.clear();
    }
    calOvulationDates.add(maxDate.subtract(const Duration(days: 14)));
    for(int i = 0 ; i < list.length ; i ++){
      list[i].setCalOvulationDate(calOvulationDates,list,i);
    }
  }

  removeRangItem(RangeItem rangeItem, List<MothItem> list) {
    rangItems.remove(rangeItem);
    if (rangItems.isEmpty) {
      calOvulationDates=[];
    } else {
      DateTime maxDate = DateTime(1990, 1, 1);
      for (var i in rangItems) {
        if (i.selectedStartDate.isAfter(maxDate)) {
          maxDate = i.selectedStartDate;
        }
      }

      for(int i = 0 ; i < list.length ; i ++){
        list[i].calOvulationDates.clear();
        list[i].aboutTheCalOvulationDateRange.clear();
      }
      calOvulationDates.add(
          maxDate.subtract(
            const Duration(days: 14),
          )
      ) ;
    }
    for(int i = 0 ; i < list.length ; i ++){
      list[i].setCalOvulationDate(calOvulationDates,list,i);
    }

  }

  setCalOvulationDate(List<DateTime> calOvulationDates,List<MothItem> items,int index) {
    List<DateTime> copyWithCalOvulationDates =[];
    copyWithCalOvulationDates.addAll(calOvulationDates);
    if (copyWithCalOvulationDates.isEmpty) {
      this.calOvulationDates.clear();
      aboutTheCalOvulationDateRange.clear();
      return;
    }
    if(currentDateTime.year == calOvulationDates[0].year && currentDateTime.month < calOvulationDates[0].month){
      return;
    }
    var mothDays =
        DateUtils.getDaysInMonth(currentDateTime.year, currentDateTime.month);
    for (int i = 1; i <= mothDays; i++) {
      var currentDate =
          DateTime(currentDateTime.year, currentDateTime.month, i);
      var offsetDay = currentDate.difference(copyWithCalOvulationDates[copyWithCalOvulationDates.length-1]).inDays.abs();
      if (offsetDay % 28 == 0) {
        this.calOvulationDates.add( DateTime(currentDateTime.year, currentDateTime.month, i));
        var startDateTime =
            this.calOvulationDates[this.calOvulationDates.length-1].add(const Duration(days: 14));
        var endDateTime = this.calOvulationDates[this.calOvulationDates.length-1].add(
              const Duration(days: 18),
            );
        var specialDateRange = DateTimeRange(start: startDateTime, end: endDateTime);
        if(startDateTime.month == currentDate.month && endDateTime.month == currentDate.month){
          aboutTheCalOvulationDateRange.add(specialDateRange);
        }else  if(startDateTime.month != currentDate.month){
          if(index + 1 >= items.length){
            return;
          }
          items[index + 1].aboutTheCalOvulationDateRange.add(specialDateRange);
        }else if(startDateTime.month == currentDate.month && endDateTime.month != currentDate.month){
          if(index + 1 >= items.length){
            return;
          }
          aboutTheCalOvulationDateRange.add(specialDateRange);
          items[index +1].aboutTheCalOvulationDateRange.add(specialDateRange);
        }
      }
    }
  }
}

class RangeItem {
  DateTime selectedStartDate;
  DateTime selectedEndDate;

  RangeItem({required this.selectedStartDate, required this.selectedEndDate});

  bool isDateInRange(DateTime date) {
    final startNum = selectedStartDate.year * 10000 +
        selectedStartDate.month * 100 +
        selectedStartDate.day;
    final endNum = selectedEndDate.year * 10000 +
        selectedEndDate.month * 100 +
        selectedEndDate.day;
    final dateNum = date.year * 10000 + date.month * 100 + date.day;

    return dateNum >= startNum && dateNum <= endNum;
  }
}
