import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/network/api.dart';
import 'package:common/common/network/dio_client.dart';
import '../../network/response/login_response.dart';
import '../base_repo.dart';

class LoginRepo extends BaseRepo {
  Future<AResponse<LoginUserResponse>> login(
      {required LoginReqBean loginReqBean}) {
    return requestOnFuture(
      Api.loginClient,
      method: Method.post,
      params: loginReqBean.toJson(),
      format: (data) => LoginUserResponse.fromJson(data),
    );
  }

  Future<AResponse<dynamic>> logOut({required LogoutReqBean bean}) {
    return requestOnFuture(Api.logoutClient,
        method: Method.post, params: bean.toJson());
  }

  Future<AResponse<LoginAuthResponse>> authCode(
      {required AuthCReqBean authCReqBean}) {
    return requestOnFuture(Api.sendAuthCode,
        method: Method.post, params: authCReqBean.toJson());
  }
}
