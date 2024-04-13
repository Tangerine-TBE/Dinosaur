import 'package:app_base/mvvm/model/chart_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class ChartResponse extends DataHolder<ChartRsp> {
  ChartResponse.fromJson(Map<dynamic, dynamic> map) {
    convert(map, (data) => ChartRsp.fromJson(data));
  }
}
