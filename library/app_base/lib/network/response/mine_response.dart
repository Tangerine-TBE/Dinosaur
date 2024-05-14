import 'package:app_base/mvvm/model/mine_bean.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

import '../../mvvm/model/comment_bean.dart';

class MineResponse extends DataHolder<MineRsq> {
  MineResponse.fromJson(dynamic map) {
    convert(
      map,
      (data) {
        return MineRsq.fromJson(data);
      },
    );
  }
}

class MineCommentResponse extends DataHolder<MineCommentRsp> {
  MineCommentResponse.fromJson(dynamic map) {
    convert(
      map,
      (data) => MineCommentRsp.fromJson(data),
    );
  }
}

class SingleCommentResponse extends DataHolder<PostsList> {
  SingleCommentResponse.fromJson(dynamic map) {
    convert(
      map,
      (data) => PostsList.fromJson(data),
    );
  }
}

class MineLikeResponse extends DataHolder<MineRsq> {
  MineLikeResponse.fromJson(dynamic map) {
    convert(
      map,
      (data) => MineRsq.fromJson(data),
    );
  }
}
