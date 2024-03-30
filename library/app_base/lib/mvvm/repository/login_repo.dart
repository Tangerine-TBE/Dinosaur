import 'dart:collection';

import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/network/api.dart';
import 'package:common/common/network/dio_client.dart';

import '../../network/response/user_response.dart';
import '../base_repo.dart';
import '../model/register_bean.dart';

class LoginRepo extends BaseRepo {
  Future<AResponse<LoginUserResponse>> login(
      {required UserReqBean userReqBean}) {
    return requestOnFuture(
      Api.loginClient,
      method: Method.post,
      params: userReqBean.toJson(),
      format: (data) => LoginUserResponse.fromJson(data),
    );
  }

  Future<AResponse<dynamic>> register({required RegisterReqBean bean }) {
    return requestOnFuture(Api.registerClient, method: Method.post,
      params: bean.toJson());
  }
  Future<AResponse<dynamic>> logOut({required LogoutReqBean bean}){
    return requestOnFuture(Api.logoutClient,method: Method.post,params: bean.toJson());
  }
  Future<AResponse<dynamic>> authCode({required String phone}){
    var map = {"mobile":phone};
    return requestOnFuture(Api.sendAuthCode,method: Method.post,params: map);
  }
}
