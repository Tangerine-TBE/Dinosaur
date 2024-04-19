import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/periodRecord/period_record_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthView extends StatelessWidget {
  final DateTime month;
  final  DateTime calOvulationDate;
  final List<RangeItem> rangeItems;
  final Function(DateTime) onDateSelected;

  MonthView({
    super.key,
   required this.calOvulationDate,
    required this.rangeItems,
    required this.month,
    required this.onDateSelected,
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
      bool isOvulation = false;
        isOvulation = calOvulationDate.day == i;
      if(rangeItems.isNotEmpty){
        for(var j in rangeItems){
         isSelected = j.isDateInRange(day);
         if(isSelected){
           break;
         }
        }
      }
      BoxDecoration decoration;
      TextStyle textStyle;
      if (isSelected) {
        decoration = BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        );
      } else {
        decoration = const BoxDecoration();
      }
      textStyle = TextStyle(
        color: isSelected
            ? (DateUtils.isSameDay(
                    DateTime.now(), DateTime(month.year, month.month, i))
                ? Colors.red
                : Colors.white)
            : (DateUtils.isSameDay(
                    DateTime.now(), DateTime(month.year, month.month, i))
                ? Colors.red
                : Colors.black),
        decoration: isSelected
            ? (DateUtils.isSameDay(
                    DateTime.now(), DateTime(month.year, month.month, i))
                ? TextDecoration.underline
                : TextDecoration.none)
            : (DateUtils.isSameDay(
                    DateTime.now(), DateTime(month.year, month.month, i))
                ? TextDecoration.underline
                : TextDecoration.none),
        decorationStyle: TextDecorationStyle.solid,
        decorationColor: Colors.black,
      );

      dayTiles.add(
        GestureDetector(
          onTap: () => onDateSelected(day),
          child: Container(
            decoration: decoration,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    '$i',
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (isOvulation && !isSelected)
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        '排卵日',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
              ],
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
