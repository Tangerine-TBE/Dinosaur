import 'package:app_base/exports.dart';
import 'package:app_base/network/api.dart';
import 'package:app_base/network/response/mine_response.dart';
import 'package:common/common/network/dio_client.dart';
import '../base_repo.dart';
import '../model/mine_bean.dart';

class MineRepo extends BaseRepo {
  Future<AResponse<MineResponse>> getCollect(MineReq mineReq) {
    return requestOnFuture(
      Api.mineCollect,
      method: Method.post,
      params: mineReq.toJson(),
      format: (data) => MineResponse.fromJson(data),
    );
  }
  Future<AResponse<MineResponse>> getPost(MineReq mineReq) {
    return requestOnFuture(
      Api.minePost,
      method: Method.post,
      params: mineReq.toJson(),
      format: (data) => MineResponse.fromJson(data),
    );
  }
  Future<AResponse<MineCommentResponse>> getMineCommentList(
      MineReq mineCommentRsq) {
    return requestOnFuture(Api.mineReview,
        method: Method.post,
        params: mineCommentRsq.toJson(),
        format: (data) => MineCommentResponse.fromJson(data));
  }
}
