library;

import 'package:common/base/mvvm/repo/api_repository.dart';

import '../../mvvm/model/user_bean.dart';

class LoginUserWithCodeResponse extends DataHolder<LoginWithCodeRspBean> {
  LoginUserWithCodeResponse.fromJson(Map<String, dynamic> map) {
    convert(map, (data) => LoginWithCodeRspBean.fromJson(data));
  }
}
class LoginUserWithPasswordResponse extends DataHolder<LoginWithCodeRspBean>{
  LoginUserWithPasswordResponse.fromJson(Map<String,dynamic> map){
    convert(map, (data) => LoginWithCodeRspBean.fromJson(data));
  }
}

class LoginAuthPhoneResponse extends DataHolder<AuthCRspPhoneBean> {
  LoginAuthPhoneResponse.fromJson(Map<String, dynamic> map) {
    convert(map, (data) => AuthCRspPhoneBean.fromJson(data));
  }
}

class LoginAuthEmailResponse extends DataHolder<AuthCRspEmailBean> {
  LoginAuthEmailResponse.fromJson(Map<String, dynamic> map) {
    convert(map, (data) => AuthCRspEmailBean.fromJson(data));
  }
}

