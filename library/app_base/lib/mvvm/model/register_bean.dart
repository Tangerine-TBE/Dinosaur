

class RegisterReqBean {
    RegisterReqBean({
        required this.password,
        required this.application,
        required this.nickName,
        required this.organization,
        required this.userName,
        required this.authCode,
        required this.gender,
        required this.birthday,
        required this.avator,
    });

    String password;
    String application;
    String nickName;
    String organization;
    String userName;
    String authCode;
    String gender;
    String birthday;
    String avator;

    factory RegisterReqBean.fromJson(Map<dynamic, dynamic> json) => RegisterReqBean(
        password: json["password"]??'',
        application: json["application"]??'',
        nickName: json["nickName"]??'',
        organization: json["organization"]??'',
        userName: json["userName"]??'',
        authCode:json["authCode"]??'',
        gender:json["gender"]??'',
        birthday:json["birthday"]??'',
        avator:json["avator"]??'',
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "application": application,
        "nickName": nickName,
        "organization": organization,
        "userName": userName,
        "authCode":authCode,
        "gender":gender,
        "birthday":birthday,
        "avator":avator,
    };
}

//NoResponseData

