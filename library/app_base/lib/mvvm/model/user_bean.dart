///验证码请求（无需token）
class AuthCRspBean {
  AuthCRspBean({
    required this.expiresIn,
  });

  int expiresIn;

  factory AuthCRspBean.fromJson(Map<dynamic, dynamic> json) => AuthCRspBean(
        expiresIn: json["expiresIn"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "expiresIn": expiresIn,
      };
}

///验证码请求
class AuthCReqBean {
  AuthCReqBean({
    required this.mobile,
  });

  String mobile;

  factory AuthCReqBean.fromJson(Map<dynamic, dynamic> json) => AuthCReqBean(
        mobile: json["mobile"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
      };
}

///登录请求（带验证码 @LoginRspBean）
class LoginReqBean {
  LoginReqBean({
    required this.mobile,
    required this.authCode,
  });

  String mobile;
  String authCode;

  factory LoginReqBean.fromJson(Map<dynamic, dynamic> json) =>
      LoginReqBean(mobile: json["mobile"], authCode: json["authCode"]);

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "authCode": authCode,
      };
}

///登出请求
class LogoutReqBean {
  LogoutReqBean({
    required this.accessToken,
  });

  String accessToken;

  factory LogoutReqBean.fromJson(Map<dynamic, dynamic> json) => LogoutReqBean(
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
      };
}

///登录响应（带验证码 @LoginReqBean）
class LoginRspBean {
  LoginRspBean({
    required this.expiresIn,
    required this.scope,
    required this.accessToken,
    required this.tokenType,
    required this.userId,
    required this.refreshToken,
  });

  int expiresIn;
  String scope;
  String accessToken;
  String tokenType;
  String userId;
  String refreshToken;

  factory LoginRspBean.fromJson(Map<dynamic, dynamic> json) => LoginRspBean(
        expiresIn: json["expiresIn"] ?? 0,
        scope: json["scope"] ?? '',
        accessToken: json["accessToken"] ?? '',
        tokenType: json["tokenType"] ?? '',
        userId: json["userId"] ?? '',
        refreshToken: json["refreshToken"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "expiresIn": expiresIn,
        "scope": scope,
        "accessToken": accessToken,
        "tokenType": tokenType,
        "userId": userId,
        "refreshToken": refreshToken,
      };
}
