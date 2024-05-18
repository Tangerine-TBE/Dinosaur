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

  Future<AResponse<dynamic>> likeComment(
      {required String commentId, required Map<String, dynamic> map}) {
    return requestOnFuture(
      "${Api.likeComment}/$commentId",
      method: Method.post,
      params: map,
    );
  }

  Future<AResponse<dynamic>> unLikeComment(
      {required String commentId, required Map<String, dynamic> map}) {
    return requestOnFuture(
      "${Api.unLikeComment}/${commentId}",
      method: Method.post,
      params: map,
    );
  }

  Future<AResponse<dynamic>> collectComment(
      {required String commentId, required Map<String, dynamic> map}) {
    return requestOnFuture(
      Api.collectComment,
      method: Method.post,
      params: map,
    );
  }

  Future<AResponse<dynamic>> likePush(
      {required String pushId, required Map<String, dynamic> map}) {
    return requestOnFuture(
      "${Api.likePush}/$pushId",
      method: Method.post,
      params: map,
    );
  }

  Future<AResponse<dynamic>> collectPush(
      {required String pushId, required Map<String, dynamic> map}) {
    return requestOnFuture(
      "${Api.collectPush}/$pushId",
      method: Method.post,
      params: map,
    );
  }

  Future<AResponse<dynamic>> unCollectPush(
      {required String pushId, required Map<String, dynamic> map}) {
    return requestOnFuture(
      "${Api.unCollectPost}/$pushId",
      method: Method.post,
      params: map,
    );
  }

  Future<AResponse<dynamic>> unLikePush(
      {required String pushId, required Map<String, dynamic> map}) {
    return requestOnFuture(
      "${Api.unLikePost}/$pushId",
      method: Method.post,
      params: map,
    );
  }
}
