import 'dart:math';

import 'package:app_base/exports.dart';
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
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 7,
              children: List.generate(7, (index) => _buildItem(index)),
            ),
            const Expanded(
              child: ScrollTargetView(
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
  const ScrollTargetView({super.key});


  @override
  State<ScrollTargetView> createState() => _ScrollTargetViewState();
}

class _ScrollTargetViewState extends State<ScrollTargetView> {
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 12 * 322.0);
  final list = <DateTime>[];

  @override
  void initState() {
    super.initState();
    _fetchDateTime();
  }


  void _fetchDateTime() {
    var now = DateTime.now();
    for (int i = 12; i >= 1; i--) {
      list.add(DateTime(now.year, now.month - i));
    }
    list.add(now);
    for (int i = 1; i <= 12; i++) {
      list.add(DateTime(now.year, now.month + i));
    }
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return DatePicker(
              height: 322,
              onDateRangeSelected: (value) {
                logE(value);
              },
              dateTime: list[index]);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: list.length);
  }
}
