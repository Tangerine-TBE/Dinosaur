import 'package:app_base/mvvm/model/comment_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class CommentResponse with DataHolder<CommentRsp> {
  CommentResponse.fromJson(Map<dynamic, dynamic> map) {
    convert(map, (data) => CommentRsp.fromJson(data));
  }
}
