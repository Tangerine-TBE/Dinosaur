import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'month_view.dart';

class DatePicker extends StatefulWidget {
  final ValueChanged onDateRangeSelected;
  final DateTime dateTime;
  final double height;

  const DatePicker(
      {super.key,
      required this.onDateRangeSelected,
      required this.dateTime,
      required this.height});

  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePicker> {
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  late DateTime _currentMonth;
  _DatePickerPageState();

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(
        widget.dateTime.year, widget.dateTime.month, widget.dateTime.day);
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(
      () {
        if (_selectedStartDate == null) {
          _selectedStartDate = selectedDate;
          _selectedEndDate = selectedDate.add(const Duration(days: 5));
          return;
        }
        if (selectedDate.isAfter(_selectedEndDate!)) {
          if (selectedDate.day - _selectedEndDate!.day == 1) {
            _selectedEndDate = selectedDate;
          } else {
            //无法超过开始之后的15天
          }
        } else if (selectedDate.isBefore(_selectedEndDate!)) {
          if (_selectedStartDate!.day < selectedDate.day ) {
            _selectedEndDate = selectedDate;
          }else if(DateUtils.isSameDay(selectedDate, _selectedStartDate)){
            _selectedEndDate = null;
            _selectedStartDate = null;
          }
        }
      },
    );
    widget.onDateRangeSelected('${_selectedStartDate}+ ${_selectedEndDate}');

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
              selectedEndDate: _selectedEndDate,
              selectedStartDate: _selectedStartDate,
              month: _currentMonth,
              onDateSelected: _onDateSelected,
            ),
          ),
        ],
      ),
    );
  }
}
