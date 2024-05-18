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

  Future<AResponse<dynamic>> deletePost({required String pathId}) {
    return requestOnFuture(
      '${Api.mineDeltePost}/$pathId',
      method: Method.delete,
    );
  }

  Future<AResponse<MineLikeResponse>> getLike(MineReq mineReq) {
    return requestOnFuture(
      Api.minePost,
      method: Method.post,
      params: mineReq.toJson(),
      format: (data) => MineLikeResponse.fromJson(data),
    );
  }

  Future<AResponse<MineCommentResponse>> getMineCommentList(
      MineReq mineCommentRsq) {
    return requestOnFuture(Api.mineReview,
        method: Method.post,
        params: mineCommentRsq.toJson(),
        format: (data) => MineCommentResponse.fromJson(data));
  }

  Future<AResponse<SingleCommentResponse>> getPostItem(
      {required String postId}) {
    return requestOnFuture(
      '${Api.querySingleOnePost}/$postId',
      method: Method.get,
      format: (data) => SingleCommentResponse.fromJson(data),
    );
  }
}
