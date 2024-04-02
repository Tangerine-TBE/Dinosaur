library;

import 'package:common/base/mvvm/repo/api_repository.dart';

import '../../mvvm/model/user_bean.dart';

class LoginUserResponse with DataHolder<LoginRspBean> {
  LoginUserResponse.fromJson(Map<String, dynamic> map) {
    convert(map, (data) => LoginRspBean.fromJson(data));
  }
}

class LoginAuthResponse with DataHolder<AuthCRspBean> {
  LoginAuthResponse.fromJson(Map<String, dynamic> map) {
    convert(map, (data) => AuthCRspBean.fromJson(data));
  }
}
