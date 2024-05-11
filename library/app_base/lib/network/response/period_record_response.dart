import 'package:app_base/mvvm/model/period_record_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class PeriodRecordResponse extends DataHolder<GetPeriodRecordRsp> {
  PeriodRecordResponse.fromJson(dynamic map) {
    convert(
      map,
      (data) => GetPeriodRecordRsp.fromJson(data),
    );
  }
}
