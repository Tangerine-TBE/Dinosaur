import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/home_bean.dart';
import 'package:app_base/network/response/home_response.dart';
import 'package:common/common/network/dio_client.dart';

import '../../network/api.dart';

class HomeRepo extends BaseRepo {
  Future<AResponse<HomeResponse>> getUserInfo({required HomeReq homeReq}) {
    return requestOnFuture(
      Api.getUserInfo,
      method: Method.get,
      params: homeReq.toJson(),
      format: (data) => HomeResponse.fromJson(data),
    );
  }
}
