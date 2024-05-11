import 'package:app_base/mvvm/model/mine_bean.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class MineResponse extends DataHolder<MineRsq> {
  MineResponse.fromJson(dynamic map) {
    convert(
      map,
      (data) => MineRsq.fromJson(data),
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

class MineLikeResponse extends DataHolder<MineLikeRsp> {
  MineLikeResponse.fromJson(dynamic map) {
    convert(
      map,
      (data) => MineLikeRsp.fromJson(data),
    );
  }
}
