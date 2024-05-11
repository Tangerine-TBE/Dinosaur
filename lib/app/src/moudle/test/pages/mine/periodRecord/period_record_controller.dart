import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/period_record_bean.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:app_base/mvvm/repository/period_record_repo.dart';
import 'package:get/get.dart';

import 'bean/month_item.dart';

class PeriodRecordController extends BaseController {
  final list = <DateTime>[];
  final listId = 1;
  final selectedDate = <String>[];
  final createDate = <String>[];
  final deletesDate = <String>[];
  final _repo = Get.find<PeriodRecordRepo>();
  final getPeriodRecordRsp = Rx(
    GetPeriodRecordRsp(
      dateList: DateList(
        endDate: DateTime.parse('1990-10-01'),
        startDate: DateTime.parse('1990-10-01'),
      ),
    ),
  );

  @override
  void onInit() async {
    super.onInit();
    _fetchDateTime();
    getPeriodRecord();
  }

  savePeriodRecord(List<RangeItem> items) async {
    DateTime startTime = DateTime(1979, 10, 1);
    DateTime endTime = DateTime(1979, 10, 1);
    for (var i in items) {
      if (i.selectedStartDate.isAfter(startTime)) {
        startTime = i.selectedStartDate;
        endTime = i.selectedEndDate;
      }
    }
    SavePeriodRecordReq savePeriodRecordReq = SavePeriodRecordReq(
      endDate: endTime,
      startDate: startTime,
      userId: User.loginRspBean!.userId,);
     await _repo.savePeriodRecord(recordReq:savePeriodRecordReq);

  }

  getPeriodRecord() async {
    final firstDayOfMonth =
    DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month, 1);

    final GetPeriodRecordReq recordReq = GetPeriodRecordReq(
        fromDate: firstDayOfMonth,
        toDate: DateTime.now(),
        userId: User.loginRspBean!.userId);
    final response = await _repo.getPeriodRecord(recordReq: recordReq);
    if (response.isSuccess) {
      if (response.data != null) {
        if (response.data!.data != null) {
          getPeriodRecordRsp.value = response.data!.data!;
        }
      }
    }
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
