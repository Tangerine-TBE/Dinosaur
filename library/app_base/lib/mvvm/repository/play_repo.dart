import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/network/api.dart';
import 'package:app_base/network/response/center_response.dart';
import 'package:common/common/network/dio_client.dart';

class PlayRepo extends BaseRepo {
  Future<AResponse<CenterResponse>> callTopCenter(
      {required TopicCenterReq topicCenterReq}) {
    return requestOnFuture(
      Api.topCenterClient,
      method: Method.post,
      params: topicCenterReq.toJson(),
      format: (data) => CenterResponse.fromJson(data),
    );
  }

  Future<AResponse<CenterCreateResponse>> createTopCenter(
      {required TopiCenterCreateReq topiCenterCreateReq}) {
    return requestOnFuture(Api.topCenterCreate,
        method: Method.post,
        params: topiCenterCreateReq.toJson(),
        format: (data) => CenterCreateResponse.fromJson(data));
  }
}
