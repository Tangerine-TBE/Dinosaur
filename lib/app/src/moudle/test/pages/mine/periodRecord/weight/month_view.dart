import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthView extends StatelessWidget {
  final DateTime month;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  final Function(DateTime) onDateSelected;

  MonthView({
    super.key,
    required this.month,
    required this.onDateSelected,
    this.selectedStartDate,
    this.selectedEndDate,
  });

  List<Widget> _buildDayTiles(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekdayOfMonth = firstDayOfMonth.weekday;
    List<Widget> dayTiles = [];
    for (int i = 0; i < firstWeekdayOfMonth - 1; i++) {
      dayTiles.add(Container()); // empty days to align the first day
    }
    for (int i = 1; i <= daysInMonth; i++) {
      final day = DateTime(month.year, month.month, i);
      bool isSelected = false;
      if(selectedStartDate != null){
        isSelected = selectedStartDate!.day ==i;
      }
      if(selectedEndDate != null){
        isSelected = (day.isAfter(
            selectedStartDate!.subtract(const Duration(days: 1))) &&
            day.isBefore(selectedEndDate!.add(const Duration(days: 1)))) ||
            day == selectedStartDate ||
            day == selectedEndDate;
      }

      BoxDecoration decoration;
      if (isSelected) {
        decoration = BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        );
      } else {
        decoration = const BoxDecoration();
      }
      dayTiles.add(
        GestureDetector(
          onTap: () => onDateSelected(day),
          child: Container(
            decoration: decoration,
            child: Center(
              child: Text(
                '$i',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return dayTiles;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 7,
      children: _buildDayTiles(context),
    );
  }
}
