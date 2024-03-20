import 'dart:convert';

UserRspBean userRspBeanFromJson(String str) => UserRspBean.fromJson(json.decode(str));

String userRspBeanToJson(UserRspBean data) => json.encode(data.toJson());
class UserRspBean {
  UserRspBean({
    required this.expiresIn,
    required this.scope,
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
  });

  int expiresIn;
  String scope;
  String accessToken;
  String tokenType;
  String refreshToken;

  factory UserRspBean.fromJson(Map<dynamic, dynamic> json) => UserRspBean(
    expiresIn: json["expiresIn"],
    scope: json["scope"],
    accessToken: json["accessToken"],
    tokenType: json["tokenType"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "expiresIn": expiresIn,
    "scope": scope,
    "accessToken": accessToken,
    "tokenType": tokenType,
    "refreshToken": refreshToken,
  };
}

UserReqBean userReqFromJson(String str) => UserReqBean.fromJson(json.decode(str));

String userReqToJson(UserReqBean data) => json.encode(data.toJson());

class UserReqBean {
  UserReqBean({
    required this.password,
    required this.application,
    required this.organization,
    required this.userName,
    required this.type,
  });

  String password;
  String application;
  String organization;
  String userName;
  String type;

  factory UserReqBean.fromJson(Map<dynamic, dynamic> json) => UserReqBean(
    password: json["password"],
    application: json["application"],
    organization: json["organization"],
    userName: json["userName"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "application": application,
    "organization": organization,
    "userName": userName,
    "type": type,
  };
}


LogoutReqBean logoutBeanFromJson(String str) => LogoutReqBean.fromJson(json.decode(str));

String logoutBeanToJson(LogoutReqBean data) => json.encode(data.toJson());

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

