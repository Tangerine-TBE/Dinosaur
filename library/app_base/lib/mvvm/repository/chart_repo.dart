import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/chart_bean.dart';
import 'package:app_base/network/api.dart';
import 'package:app_base/network/response/chart_response.dart';
import 'package:common/common/network/dio_client.dart';

class ChartRepo extends BaseRepo {
  Future<AResponse<ChartResponse>> getCharts(ChartReq chartReq) {
    return requestOnFuture(Api.getCharts,
        method: Method.post,
        params: chartReq.toJson(),
        format: (data) => ChartResponse.fromJson(data));
  }

  Future<AResponse<dynamic>> pushChart(ChartCreateReq chartCreateReq) {
    return requestOnFuture(Api.pushCharts,
        method: Method.post, params: chartCreateReq.toJson());
  }
}
