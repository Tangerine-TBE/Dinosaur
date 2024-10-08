import 'dart:collection';

import 'package:app_base/mvvm/model/register_bean.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/network/api.dart';
import 'package:common/common/network/dio_client.dart';
import '../../network/response/login_response.dart';
import '../base_repo.dart';

class LoginRepo extends BaseRepo {
  Future<AResponse<LoginUserWithCodeResponse>> loginWithCode(
      {required LoginWithCodeReqBean loginReqBean}) {
    return requestOnFuture(
      Api.loginClientCode,
      method: Method.post,
      params: loginReqBean.toJson(),
      format: (data) => LoginUserWithCodeResponse.fromJson(data),
    );
  }

  Future<AResponse<dynamic>> userCancel({
    required Map<String, dynamic> map,
  }) {
    return requestOnFuture(
      Api.cancelUser,
      method: Method.post,
      params: map,
    );
  }

  Future<AResponse<LoginUserWithPasswordResponse>> loginWithPassword(
      {required LoginReqBean loginReqBean}) {
    return requestOnFuture(
      Api.loginClientPassword,
      method: Method.post,
      params: loginReqBean.toJson(),
      format: (data) => LoginUserWithPasswordResponse.fromJson(data),
    );
  }

  Future<AResponse<dynamic>> logOut({required LogoutReqBean bean}) {
    return requestOnFuture(Api.logoutClient,
        method: Method.post, params: bean.toJson());
  }

  Future<AResponse<LoginAuthPhoneResponse>> authCodePhone(
      {required AuthCReqPhoneBean authCReqBean}) {
    return requestOnFuture(
      Api.sendAuthCodePhone,
      method: Method.post,
      params: authCReqBean.toJson(),
      format: (data) => LoginAuthPhoneResponse.fromJson(data),
    );
  }

  Future<AResponse<dynamic>> register(
      {required RegisterReqBean registerReqBean}) {
    return requestOnFuture(
      Api.registerClient,
      method: Method.post,
      params: registerReqBean.toJson(),
    );
  }

  Future<AResponse<LoginAuthEmailResponse>> authCodeEmail(
      {required AuthCReqEmailBean authCReqEmailBean}) {
    return requestOnFuture(
      Api.sendAuthCodeEmail,
      method: Method.post,
      params: authCReqEmailBean.toJson(),
      format: (data) => LoginAuthEmailResponse.fromJson(data),
    );
  }

  Future<AResponse<dynamic>> forgotPassword(
      {required ForgotReqBean forgotReqBean}) {
    return requestOnFuture(
      Api.forgotPassword,
      method: Method.post,
      params: forgotReqBean.toJson(),
    );
  }
}
