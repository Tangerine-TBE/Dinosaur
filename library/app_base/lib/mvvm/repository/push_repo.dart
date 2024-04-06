import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:common/common/network/dio_client.dart';

import '../../network/api.dart';
import '../../network/response/push_response.dart';

class PushRepo extends BaseRepo {
  Future<AResponse<PushResponse>> getPushMsg(PushMsgReq pushMsgReq) {
    return requestOnFuture(Api.getPushMsg,
        method: Method.post,
        params: pushMsgReq.toJson(),
        format: (data) => PushResponse.fromJson(data));
  }

  Future<AResponse<dynamic>> pushMsg(PushCreateReq pushCreateReq) {
    return requestOnFuture(Api.pushMsg,
        method: Method.post, params: pushCreateReq.toJson());
  }
}
