import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../period_record_page.dart';
import 'month_view.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime, DateTime) onNextMonthEndDateChanged;
  final ValueChanged onNextMonthEndDateDismiss;
  final Function(DateTime, DateTime) onLastMothEndDateChanged;
  final DateTime dateTime;
  final double height;
  final List<RangeItem> rangeItems;

  const DatePicker(
      {super.key,
      required this.onNextMonthEndDateChanged,
      required this.onNextMonthEndDateDismiss,
      required this.onLastMothEndDateChanged,
      required this.dateTime,
      required this.rangeItems,
      required this.height});

  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePicker> {
  late DateTime _currentMonth;

  _DatePickerPageState();

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(
        widget.dateTime.year, widget.dateTime.month, widget.dateTime.day);
  }

  bool checkSelectedDateEnable(DateTime selectedDate, List<RangeItem> item) {
    return false;
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(
      () {
        if (widget.rangeItems.isNotEmpty) {
          bool hashDeal = false;
          for (var i in widget.rangeItems) {
            if (i.isDateInRange(selectedDate)) {
              //在任意一个区间范围内
              if (i.selectedStartDate.day == selectedDate.day) {
                widget.rangeItems.remove(i);
                if (i.selectedEndDate.month > _currentMonth.month) {
                  widget.onNextMonthEndDateDismiss(i.selectedEndDate.day);
                }
                hashDeal = true;
                return;
              } else {
                hashDeal = true;
                i.selectedEndDate = selectedDate;
                if (i.selectedStartDate.month < _currentMonth.month) {
                  widget.onLastMothEndDateChanged(i.selectedStartDate,i.selectedEndDate);
                }
              }
            }
          }
          if (!hashDeal) {
            bool canInsertNewRange = true;
            for (var i in widget.rangeItems) {
              if (i.selectedEndDate.day + 1 == selectedDate.day) {
                if (i.selectedStartDate.day + 14 < selectedDate.day) {
                  canInsertNewRange = false;
                }
                for (var j in widget.rangeItems) {
                  if (i != j) {
                    if ((i.selectedStartDate.day - (selectedDate.day + 1))
                                .abs() <
                            3 ||
                        (i.selectedStartDate.day - (selectedDate.day + 1))
                                .abs() <
                            8) {
                      if (j.selectedEndDate.day > i.selectedEndDate.day) {
                        canInsertNewRange = false;
                      }
                    }
                  }
                }
                if (canInsertNewRange) {
                  i.selectedEndDate = selectedDate;
                  hashDeal = true;
                  if (i.selectedStartDate.month < _currentMonth.month) {
                    widget.onLastMothEndDateChanged(
                        i.selectedStartDate, i.selectedEndDate);
                  }
                }
                return;
              }
            }
          }
          if (!hashDeal) {
            //这里涉及到是否新建问题
            bool canInsertNewRange = false;
            DateTime updateStartDate = selectedDate;
            DateTime updateEndDate = selectedDate.add(const Duration(days: 4));
            for (var i in widget.rangeItems) {
              if (updateStartDate.difference(i.selectedEndDate).inDays <=3) {
                canInsertNewRange = false;
                break;
              } else {
                canInsertNewRange = true;
              }
            }
            if (canInsertNewRange) {
              widget.rangeItems.add(
                RangeItem(
                    selectedStartDate: updateStartDate,
                    selectedEndDate: updateEndDate),
              );
              hashDeal = true;
              return;
            }
          }
        } else {
          //6.没有存在可用的区间范围，则新建一个以选择日期为开始，选择日期之后五天为结尾的区间范围，并添加为新的区间
          final selectedEndDate = selectedDate.add(
            const Duration(days: 4),
          );
          if (selectedEndDate.month > _currentMonth.month) {
            widget.onNextMonthEndDateChanged(selectedDate.add(const Duration(days: 4)), selectedDate);
          } else {
            widget.rangeItems.add(
              RangeItem(
                selectedStartDate: selectedDate,
                selectedEndDate: selectedEndDate,
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: widget.height,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text('${_currentMonth.month}月'),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: MonthView(
              month: _currentMonth,
              onDateSelected: _onDateSelected,
              rangeItems: widget.rangeItems,
            ),
          ),
        ],
      ),
    );
  }
}
