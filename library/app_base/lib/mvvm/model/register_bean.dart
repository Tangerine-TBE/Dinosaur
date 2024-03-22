
import 'dart:convert';

RegisterReqBean registerFromJson(String str) => RegisterReqBean.fromJson(json.decode(str));

String registerToJson(RegisterReqBean data) => json.encode(data.toJson());

class RegisterReqBean {
    RegisterReqBean({
        required this.password,
        required this.application,
        required this.nickName,
        required this.organization,
        required this.userName,
    });

    String password;
    String application;
    String nickName;
    String organization;
    String userName;

    factory RegisterReqBean.fromJson(Map<dynamic, dynamic> json) => RegisterReqBean(
        password: json["password"]??'',
        application: json["application"]??'',
        nickName: json["nickName"]??'',
        organization: json["organization"]??'',
        userName: json["userName"]??'',
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "application": application,
        "nickName": nickName,
        "organization": organization,
        "userName": userName,
    };
}

//NoResponseData

