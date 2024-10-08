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
  final getPeriodRecordRsp1 = Rxn();

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  onReady() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    await _fetchDateTime();
    await getPeriodRecord();
    dismiss();
    super.onReady();
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
      userId: User.loginRspBean!.userId,
    );
    await _repo.savePeriodRecord(recordReq: savePeriodRecordReq);
  }

  Future getPeriodRecord() async {
    final firstDayOfMonth =
        DateTime(DateTime.now().year, DateTime.now().month, 1);

    final GetPeriodRecordReq recordReq = GetPeriodRecordReq(
        fromDate: firstDayOfMonth,
        toDate: DateTime.now(),
        userId: User.loginRspBean!.userId);
    final response = await _repo
        .getPeriodRecord1(map: {'userId': User.loginRspBean!.userId});
    if (response.isSuccess) {
      if (response.data != null) {
        if (response.data!.data != null) {
          getPeriodRecordRsp1.value = response.data!.data!;
        }
      }
    }else{
      showError(response.message);
    }
  }

  Future _fetchDateTime() async{
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
