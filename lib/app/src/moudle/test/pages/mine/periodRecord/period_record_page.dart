import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/period_record_bean.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/periodRecord/bean/month_item.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/periodRecord/period_record_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/periodRecord/weight/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PeriodRecordPage extends BaseEmptyPage<PeriodRecordController> {
  const PeriodRecordPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    controller.list;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          '经期记录',
          style: TextStyle(fontSize: SizeConfig.titleTextDefaultSize),
        ),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 7,
                children: List.generate(7, (index) => _buildItem(index)),
              ),
              const Divider(height: 1),
              Expanded(
                child: Obx(
                  () => ScrollTargetView(
                    dateSelectValue: (item) {
                      controller.savePeriodRecord(item);
                    },
                    getPeriodRecordRsp: controller.getPeriodRecordRsp.value,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildItem(int index) {
    if (index == 0) {
      return const Center(
        child: Text(
          '一',
          style: TextStyle(color: Colors.pinkAccent),
        ),
      );
    } else if (index == 1) {
      return const Center(
        child: Text('二', style: TextStyle(color: Colors.pinkAccent)),
      );
    } else if (index == 2) {
      return const Center(
        child: Text('三', style: TextStyle(color: Colors.pinkAccent)),
      );
    } else if (index == 3) {
      return const Center(
        child: Text('四', style: TextStyle(color: Colors.pinkAccent)),
      );
    } else if (index == 4) {
      return const Center(
        child: Text('五', style: TextStyle(color: Colors.pinkAccent)),
      );
    } else if (index == 5) {
      return const Center(
        child: Text('六', style: TextStyle(color: Colors.pinkAccent)),
      );
    } else if (index == 6) {
      return const Center(
        child: Text('日', style: TextStyle(color: Colors.pinkAccent)),
      );
    }
  }
}

class ScrollTargetView extends StatefulWidget {
  const ScrollTargetView(
      {super.key,
      required this.dateSelectValue,
      required this.getPeriodRecordRsp});

  final GetPeriodRecordRsp getPeriodRecordRsp;
  final Function(List<RangeItem> item) dateSelectValue;

  @override
  State<ScrollTargetView> createState() => _ScrollTargetViewState();
}

class _ScrollTargetViewState extends State<ScrollTargetView> {
  final ScrollController _scrollController = ScrollController();
  final list = <MothItem>[];

  @override
  void initState() {
    super.initState();
    _fetchDateTime();
  }

  void _fetchDateTime() {
    var now = DateTime.now();
    list.add(MothItem(currentDateTime: now));
    for (int i = 1; i <= 12; i++) {
      list.add(MothItem(currentDateTime: DateTime(now.year, now.month + i)));
    }
    _fetchSelectedDateTime();
  }

  void _fetchSelectedDateTime() {
    if (widget.getPeriodRecordRsp.dateList.startDate.year != 1990) {
      RangeItem rangeItem = RangeItem(
        selectedStartDate: widget.getPeriodRecordRsp.dateList.startDate,
        selectedEndDate: widget.getPeriodRecordRsp.dateList.endDate,
      );
      if (rangeItem.selectedStartDate.month < DateTime.now().month &&
          rangeItem.selectedEndDate.month < DateTime.now().month) {
        //推算2024 3 4 间隔  30天 = 3月 29 非本月 继续
        DateTime calStartDateTime = rangeItem.selectedStartDate;
        DateTime calEndDateTime = rangeItem.selectedEndDate;
        while (calEndDateTime.year != DateTime.now().year ||
            calEndDateTime.month != DateTime.now().month) {
          calStartDateTime = calStartDateTime.add(const Duration(days: 28));
          calEndDateTime = calEndDateTime.add(const Duration(days: 28));
        }
        list[0].addRangItem(
            RangeItem(
                selectedStartDate: calStartDateTime,
                selectedEndDate: calEndDateTime),
            list);
      } else {
        list[0].addRangItem(rangeItem, list);
      }
    }
  }

  void onNextMonthEndDateChanged(
      DateTime endDateTime, int index, DateTime dateTime) {
    var item = list[index + 1];
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
      list[index + 1] = item;
    } else {
      bool canAdd = true;
      for (var i in item.rangItems) {
        if (endDateTime.difference(i.selectedStartDate).inDays < 3) {
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
  }

  void onNextMonthEndDateDismiss(int nextMothDay, int index) {
    var item = list[index + 1];
    for (var i in item.rangItems) {
      if (i.selectedEndDate.day == nextMothDay) {
        item.removeRangItem(i, list);
        return;
      }
    }
  }

  void onLastMothEndDateChanged(
      DateTime startDateTime, DateTime endDateTime, int index) {
    var item = list[index - 1];
    for (var i in item.rangItems) {
      if (i.selectedStartDate.day == startDateTime.day) {
        i.selectedEndDate = endDateTime;
      }
    }
  }

  Future checkNextMothDate(
      DateTime startDate, DateTime endDate, int index) async {
    var item = list[index + 1];
    if (item.rangItems.isEmpty) {
      return true;
    } else {
      bool canAdd = true;
      for (var i in item.rangItems) {
        if (i.selectedStartDate.difference(endDate).inDays <= 3) {
          canAdd = false;
        }
      }
      return canAdd;
    }
  }

  Future checkLastMothDate(
      DateTime startDate, DateTime endDate, int index) async {
    if (index == 0) {
      return true;
    }
    var item = list[index - 1];
    if (item.rangItems.isEmpty) {
      return true;
    } else {
      bool canAdd = true;
      for (var i in item.rangItems) {
        if (startDate.difference(i.selectedEndDate).inDays <= 3) {
          canAdd = false;
        }
      }
      return canAdd;
    }
  }

  onDateSelected(DateTime selectedDate, int index) {
    setState(() {
      if (list[index].rangItems.isNotEmpty) {
        bool hashDeal = false;
        for (var i in list[index].rangItems) {
          if (i.isDateInRange(selectedDate)) {
            //在任意一个区间范围内
            if (i.selectedStartDate.day == selectedDate.day) {
              list[index].removeRangItem(i, list);
              if (i.selectedEndDate.month > list[index].currentDateTime.month) {
                onNextMonthEndDateDismiss(i.selectedEndDate.day, index);
              }
              hashDeal = true;
              widget.dateSelectValue.call(list[0].rangItems);
              return;
            } else {
              hashDeal = true;
              i.selectedEndDate = selectedDate;
              if (i.selectedStartDate.month <
                  list[index].currentDateTime.month) {
                onLastMothEndDateChanged(
                    i.selectedStartDate, i.selectedEndDate, index);
              }
              widget.dateSelectValue.call(list[0].rangItems);
            }
          }
        }
        if (!hashDeal) {
          bool canInsertNewRange = true;
          for (var i in list[index].rangItems) {
            if (i.selectedEndDate.day + 1 == selectedDate.day) {
              if (i.selectedStartDate.day + 14 < selectedDate.day) {
                canInsertNewRange = false;
              }
              for (var j in list[index].rangItems) {
                if (i != j) {
                  if ((i.selectedStartDate.day - (selectedDate.day + 1)).abs() <
                          3 ||
                      (i.selectedStartDate.day - (selectedDate.day + 1)).abs() <
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
                if (i.selectedStartDate.month <
                    list[index].currentDateTime.month) {
                  onLastMothEndDateChanged(
                      i.selectedStartDate, i.selectedEndDate, index);
                }
              }
              widget.dateSelectValue.call(list[0].rangItems);
              return;
            }
          }
        }
        if (!hashDeal) {
          //这里涉及到是否新建问题
          bool canInsertNewRange = false;
          DateTime updateStartDate = selectedDate;
          DateTime updateEndDate = selectedDate.add(const Duration(days: 4));
          for (var i in list[index].rangItems) {
            if (selectedDate.isAfter(DateTime.now())) {
              showToast('未来设置日期无效');
              canInsertNewRange = false;
              break;
            }
            if (selectedDate.isBefore(i.selectedStartDate)) {
              int offset2 =
                  i.selectedStartDate.difference(updateEndDate).inDays;
              if (offset2 <= 3) {
                canInsertNewRange = false;
                showToast('添加一段新经期？太频繁了吧！至少间隔3天');
                break;
              }
            } else if (selectedDate.isAfter(i.selectedEndDate)) {
              int offset2 =
                  updateStartDate.difference(i.selectedEndDate).inDays;
              if (offset2 <= 3) {
                canInsertNewRange = false;
                showToast('添加一段新经期？太频繁了吧！至少间隔3天');
                break;
              }
            }
            canInsertNewRange = true;
          }
          if (canInsertNewRange) {
            list[index].addRangItem(
              RangeItem(
                  selectedStartDate: updateStartDate,
                  selectedEndDate: updateEndDate),
              list,
            );
            hashDeal = true;
            //选择一个区间内最晚的日期
            widget.dateSelectValue.call(list[0].rangItems);

            return;
          }
        }
      } else {
        //6.没有存在可用的区间范围，则新建一个以选择日期为开始，选择日期之后五天为结尾的区间范围，并添加为新的区间
        if (selectedDate.isAfter(DateTime.now())) {
          showToast('未来日期设置无效');
          return;
        }
        final selectedEndDate = selectedDate.add(
          const Duration(days: 4),
        );
        if (selectedEndDate.month > list[index].currentDateTime.month) {
          onNextMonthEndDateChanged(
              selectedDate.add(const Duration(days: 4)), index, selectedDate);
        } else {
          checkNextMothDate(selectedDate, selectedEndDate, index).then((value) {
            if (value) {
              checkLastMothDate(selectedDate, selectedEndDate, index)
                  .then((value) {
                if (value) {
                  list[index].addRangItem(
                    RangeItem(
                      selectedStartDate: selectedDate,
                      selectedEndDate: selectedEndDate,
                    ),
                    list,
                  );
                }
              });
            }
          });
        }
        widget.dateSelectValue.call(list[0].rangItems);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return DatePicker(
            menstrualDate: list[index].calOvulationDates,
            dateTime: list[index].currentDateTime,
            rangeItems: list[index].rangItems,
            aboutTheCalOvulationDateRange:
                list[index].aboutTheCalOvulationDateRange,
            onDateSelected: (selectedDateTime) {
              onDateSelected(selectedDateTime, index);
            },
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
