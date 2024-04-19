import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bean/month_item.dart';
import 'month_view.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime dateTime;
  final double height;
  final List<DateTime> menstrualDate;
  final List<DateTimeRange> aboutTheCalOvulationDateRange ;
  final List<RangeItem> rangeItems;

   const DatePicker(
      {super.key,
        required this.menstrualDate,
       required this.aboutTheCalOvulationDateRange ,
        required this.onDateSelected,
      required this.dateTime,
      required this.rangeItems,
      required this.height});

  @override
  _DatePickerPageState createState() {
    return _DatePickerPageState();
  }
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
   _onDateSelected(DateTime selectedDate)  {
      widget.onDateSelected(selectedDate);
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
              aboutTheCalOvulationDateRange:widget.aboutTheCalOvulationDateRange,
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
