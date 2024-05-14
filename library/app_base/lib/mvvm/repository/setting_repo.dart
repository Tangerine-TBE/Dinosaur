import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/setting_bean.dart';
import 'package:common/common/network/dio_client.dart';

import '../../network/api.dart';
import '../../network/response/setting_response.dart';

class SettingRepo extends BaseRepo {
  Future<AResponse<dynamic>> saveSettingInfo(
      {required SaveSettingReq saveSettingReq}) {
    return requestOnFuture(
      Api.saveSettingInfo,
      method: Method.post,
      params: saveSettingReq.toJson(),
    );
  }

  Future<AResponse<GetSettingInfoResponse>> getSettingInfo(
      {required Map<String, dynamic> params}) {
    return requestOnFuture(
      Api.getSettingInfo,
      params: params,
      method: Method.post,
      format: (data) => GetSettingInfoResponse.fromJson(data),
    );
  }
}
