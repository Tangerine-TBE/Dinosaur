import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/period_record_bean.dart';
import 'package:app_base/network/api.dart';
import 'package:app_base/network/response/period_record_response.dart';
import 'package:common/common/network/dio_client.dart';

class PeriodRecordRepo extends BaseRepo {
  Future<AResponse<dynamic>> savePeriodRecord(
      {required SavePeriodRecordReq recordReq}) {
    return requestOnFuture(
      Api.savePeriodRecord,
      method: Method.post,
      params: recordReq.toJson(),
    );
  }

  Future<AResponse<PeriodRecordResponse>> getPeriodRecord(
      {required GetPeriodRecordReq recordReq}) {
    return requestOnFuture(
      Api.getPeriodRecord,
      method: Method.post,
      params: recordReq.toJson(),
      format: (data) => PeriodRecordResponse.fromJson(data),
    );
  }
  Future<AResponse<PeriodRecordResponse1>> getPeriodRecord1(
      {required Map<String,dynamic> map}) {
    return requestOnFuture(
      Api.getPeriodRecord1,
      method: Method.post,
      params: map,
      format: (data) => PeriodRecordResponse1.fromJson(data),
    );
  }
}
