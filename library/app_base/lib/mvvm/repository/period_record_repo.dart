import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/period_record_bean.dart';
import 'package:app_base/network/api.dart';
import 'package:common/common/network/dio_client.dart';

class PeriodRecordRepo extends BaseRepo {
  Future<AResponse<dynamic>> savePeriodRecord(
      {required SavePeriodRecordReq recordReq}) {
    return requestOnFuture(Api.savePeriodRecord,
        method: Method.post, params: recordReq.toJson(),);
  }

  Future<AResponse<GetPeriodRecordRsp>> getPeriodRecord(
      {required GetPeriodRecordReq recordReq}) {
    return requestOnFuture(Api.savePeriodRecord,
        method: Method.post, params: recordReq.toJson(),);
  }
}
