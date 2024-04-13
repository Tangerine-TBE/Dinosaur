import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class PushResponse extends DataHolder<PushMsgRsp> {
  PushResponse.fromJson(Map<dynamic, dynamic> map) {
    convert(map, (data) => PushMsgRsp.fromJson(data));
  }
}
