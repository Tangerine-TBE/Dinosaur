import 'package:app_base/mvvm/model/comment_bean.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class CommentListResponse with DataHolder<CommentListRsp> {
  CommentListResponse.fromJson(Map<dynamic, dynamic> map) {
    convert(map, (data) => CommentListRsp.fromJson(data));
  }
}

class CommentCreateResponse with DataHolder<CommentList> {
  CommentCreateResponse.fromJson(Map<dynamic, dynamic> map) {
    convert(map, (data) => CommentList.fromJson(data));
  }
}
