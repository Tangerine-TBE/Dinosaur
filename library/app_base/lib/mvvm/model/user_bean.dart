import 'dart:convert';

///验证码请求（无需token）
class AuthCRspPhoneBean {
  AuthCRspPhoneBean({
    required this.expiresIn,
  });

  int expiresIn;

  factory AuthCRspPhoneBean.fromJson(Map<dynamic, dynamic> json) =>
      AuthCRspPhoneBean(
        expiresIn: json["expiresIn"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "expiresIn": expiresIn,
      };
}

///验证码请求
class AuthCReqPhoneBean {
  AuthCReqPhoneBean({
    required this.mobile,
  });

  String mobile;

  factory AuthCReqPhoneBean.fromJson(Map<dynamic, dynamic> json) =>
      AuthCReqPhoneBean(
        mobile: json["mobile"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
      };
}

class AuthCReqEmailBean {
  String mail;
  String type;

  AuthCReqEmailBean({required this.mail, required this.type});

  factory AuthCReqEmailBean.fromJson(Map<dynamic, dynamic> json) =>
      AuthCReqEmailBean(
        mail: json['mail'] ?? '',
        type: json['mobile'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "mail": mail,
        "type": type,
      };
}

class AuthCRspEmailBean {
  String expiresIn;

  AuthCRspEmailBean({required this.expiresIn});

  factory AuthCRspEmailBean.fromJson(Map<dynamic, dynamic> json) =>
      AuthCRspEmailBean(
        expiresIn: json['expiresIn'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "expiresIn": expiresIn,
      };
}

class LoginReqBean {
  final String application;
  final String organization;
  final String userName;
  final String password;
  final String type;

  LoginReqBean(
      {required this.application,
      required this.organization,
      required this.userName,
      required this.password,
      required this.type});

  Map<String, dynamic> toJson() => {
        "application": application,
        "organization": organization,
        "userName": userName,
        "password": password,
        "type": type,
      };
}

class LoginRspBean {
  final String accessToken;
  final String expiresIn;
  final String refreshToken;
  final String scope;
  final String tokenType;
  final String userId;

  LoginRspBean({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.scope,
    required this.tokenType,
    required this.userId,
  });

  factory LoginRspBean.fromJson(Map<dynamic, dynamic> json) => LoginRspBean(
        accessToken: json['accessToken'] ?? '',
        expiresIn: json['expiresIn'] ?? 0,
        refreshToken: json['refreshToken'] ?? '',
        scope: json['scope'] ?? '',
        tokenType: json['tokenType'] ?? '',
        userId: json['userId'] ?? '',
      );
}

///登录请求（带验证码 @LoginRspBean）
class LoginWithCodeReqBean {
  LoginWithCodeReqBean({
    required this.mobile,
    required this.authCode,
  });

  String mobile;
  String authCode;

  factory LoginWithCodeReqBean.fromJson(Map<dynamic, dynamic> json) =>
      LoginWithCodeReqBean(mobile: json["mobile"], authCode: json["authCode"]);

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
class LoginWithCodeRspBean {
  LoginWithCodeRspBean({
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

  factory LoginWithCodeRspBean.fromJson(Map<dynamic, dynamic> json) =>
      LoginWithCodeRspBean(
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

class ForgotReqBean {
  final String userName;
  final String password;
  final String authCode;

  ForgotReqBean(
      {required this.userName, required this.password, required this.authCode});

  factory ForgotReqBean.create(Map<dynamic, dynamic> json) => ForgotReqBean(
      userName: json['userName'] ?? '',
      password: json['password'] ?? '',
      authCode: json['authCode'] ?? '');

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'password': password,
        'authCode': authCode,
      };
}
