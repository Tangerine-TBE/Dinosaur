import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/periodRecord/period_record_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/periodRecord/weight/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class PeriodRecordPage extends BaseEmptyPage<PeriodRecordController> {
  const PeriodRecordPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    controller.list;
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 7,
              children: List.generate(7, (index) => _buildItem(index)),
            ),
            Expanded(
              child: ScrollTargetView(
                dateSelectValue: (String, int) {
                  logE(String);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildItem(int index) {
    if (index == 0) {
      return Center(
        child: Text('一'),
      );
    } else if (index == 1) {
      return Center(
        child: Text('二'),
      );
    } else if (index == 2) {
      return Center(
        child: Text('三'),
      );
    } else if (index == 3) {
      return Center(
        child: Text('四'),
      );
    } else if (index == 4) {
      return Center(
        child: Text('五'),
      );
    } else if (index == 5) {
      return Center(
        child: Text('六'),
      );
    } else if (index == 6) {
      return Center(
        child: Text('日'),
      );
    }
  }
}

class ScrollTargetView extends StatefulWidget {
  const ScrollTargetView({super.key, required this.dateSelectValue});

  final Function(String, int) dateSelectValue;

  @override
  State<ScrollTargetView> createState() => _ScrollTargetViewState();
}

class _ScrollTargetViewState extends State<ScrollTargetView> {
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 12 * 322.0);
  final list = <MothItem>[];

  @override
  void initState() {
    super.initState();
    _fetchDateTime();
  }

  void onSelectedDateChange(String value, int index) {
    setState(() {
      list[index].setRangItems(value);
    });
  }

  void _fetchDateTime() {
    var now = DateTime.now();
    for (int i = 12; i >= 1; i--) {
      list.add(MothItem(currentDateTime: DateTime(now.year, now.month - i)));
    }
    list.add(MothItem(currentDateTime: now));
    for (int i = 1; i <= 12; i++) {
      list.add(MothItem(currentDateTime: DateTime(now.year, now.month + i)));
    }
  }

  void onNextMonthEndDateChanged(
      DateTime endDateTime, int index, DateTime dateTime) {
    setState(() {
      var item = list[index + 1];
      var currentDateTime = item.currentDateTime;
      if (item.rangItems.isEmpty) {
        item.rangItems.add(
          RangeItem(
            selectedStartDate: dateTime,
            selectedEndDate: endDateTime,
          ),
        );
        list[index].rangItems.add(
              RangeItem(
                selectedStartDate: dateTime,
                selectedEndDate: dateTime.add(
                  const Duration(days: 4),
                ),
              ),
            );
        list.insert(index + 1, item);
      } else {
        bool canAdd = true;
        for (var i in item.rangItems) {
          if (endDateTime.difference(i.selectedStartDate) .inDays <  3) {
            canAdd = false;
          }
        }
        if (canAdd) {
          item.rangItems.add(
            RangeItem(
              selectedStartDate: dateTime,
              selectedEndDate: endDateTime,
            ),
          );
          list[index].rangItems.add(
                RangeItem(
                  selectedStartDate: dateTime,
                  selectedEndDate: dateTime.add(
                    const Duration(days: 4),
                  ),
                ),
              );
          list.insert(index + 1, item);
        }
      }
    });
  }

  void onNextMonthEndDateDismiss(int nextMothDay, int index) {
    setState(() {
      var item = list[index + 1];
      for (var i in item.rangItems) {
        if (i.selectedEndDate.day == nextMothDay) {
          item.rangItems.remove(i);
          return;
        }
      }
    });
  }
  void onLastMothEndDateChanged(DateTime startDateTime,DateTime endDateTime,int index){
    setState(() {
      var item = list[index - 1];
      for(var i in item.rangItems){
        if(i.selectedStartDate.day == startDateTime.day){
          i.selectedEndDate = endDateTime;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return DatePicker(
            height: 322,
            onNextMonthEndDateChanged: (
              value,
              dateTime,
            ) {
              onNextMonthEndDateChanged(
                value,
                index,
                dateTime,
              );
            },
            onNextMonthEndDateDismiss: (value) {
              onNextMonthEndDateDismiss(
                value,
                index,
              );
            },
            onLastMothEndDateChanged:(startDateTime,endDateTime){
              onLastMothEndDateChanged(startDateTime,endDateTime, index);
            },
            dateTime: list[index].currentDateTime,
            rangeItems: list[index].rangItems,
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: list.length);
  }
}

class MothItem {
  final DateTime currentDateTime;
  final List<RangeItem> rangItems = <RangeItem>[];
  DateTime? calOvulationDate;

  MothItem({required this.currentDateTime});

  setRangItems(String value) {
    if (value.isNotEmpty) {
      List<String> splitString = value.split('-');
      final rangeItem = RangeItem(
          selectedStartDate: DateTime.tryParse(splitString[0])!,
          selectedEndDate: DateTime.tryParse(splitString[1])!);
      rangItems.add(rangeItem);
      if (rangItems.length > 1) {
        //月经不调
        rangItems[rangItems.length - 1]
            .selectedEndDate
            .add(const Duration(days: 10));
      } else {
        //月经正常
        rangItems[rangItems.length - 1]
            .selectedEndDate
            .add(const Duration(days: 15));
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
