import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/comment_bean.dart';
import 'package:app_base/network/response/comment_response.dart';
import 'package:common/common/network/dio_client.dart';

import '../../network/api.dart';

class DetailsRepo extends BaseRepo {
  Future<AResponse<CommentListResponse>> getCommentList(
      CommentListReq commentReq) {
    return requestOnFuture(Api.getCommentList,
        method: Method.post,
        params: commentReq.toJson(),
        format: (data) => CommentListResponse.fromJson(data));
  }

  Future<AResponse<CommentCreateResponse>> createComment(
      CommentCreateReq commentCreateReq) {
    return requestOnFuture(Api.createComment,
        method: Method.post,
        params: commentCreateReq.toJson(),
        format: (data) => CommentCreateResponse.fromJson(data));
  }
}
