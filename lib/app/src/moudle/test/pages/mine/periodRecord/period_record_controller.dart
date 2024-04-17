import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';

class PeriodRecordController extends BaseController{
  final list = <DateTime>[];
  final listId = 1;
  @override
  void onInit() async{
    super.onInit();
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
}