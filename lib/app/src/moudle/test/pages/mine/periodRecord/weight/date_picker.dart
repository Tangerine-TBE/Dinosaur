import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bean/month_item.dart';
import 'month_view.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime dateTime;
  final List<DateTime> menstrualDate;
  final List<DateTimeRange> aboutTheCalOvulationDateRange;
  final List<RangeItem> rangeItems;

  const DatePicker({super.key,
    required this.menstrualDate,
    required this.aboutTheCalOvulationDateRange,
    required this.onDateSelected,
    required this.dateTime,
    required this.rangeItems,
  });

  @override
  _DatePickerPageState createState() {
    return _DatePickerPageState();
  }
}

class _DatePickerPageState extends State<DatePicker> {
  late DateTime _currentMonth;
  late double i ;
  _DatePickerPageState();

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(
        widget.dateTime.year, widget.dateTime.month, widget.dateTime.day);
    i =calculateSundaysInMonth(_currentMonth) * 84;
  }

  _onDateSelected(DateTime selectedDate) {
    widget.onDateSelected(selectedDate);
  }
  int calculateSundaysInMonth(DateTime month) {
    int sundays = 0;
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(month.year, month.month, i);
      if (date.weekday == DateTime.sunday) {
        sundays++;
      }
    }

    return sundays;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: i,
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
              aboutTheCalOvulationDateRange: widget.aboutTheCalOvulationDateRange,
              calOvulationDate: widget.menstrualDate,
              onDateSelected: _onDateSelected,
              rangeItems: widget.rangeItems,
            ),
          ),
        ],
      ),
    );
  }
}
