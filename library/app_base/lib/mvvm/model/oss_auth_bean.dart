class OssAuthBean {
    OssAuthBean({
        required this.accessKeyId,
        required this.securityToken,
        required this.accessKeySecret,
        required this.expiration,
    });

    String accessKeyId;
    String securityToken;
    String accessKeySecret;
    String expiration;

    factory OssAuthBean.fromJson(Map<dynamic, dynamic> json) => OssAuthBean(
        accessKeyId: json["accessKeyId"]??'',
        securityToken: json["securityToken"]??'',
        accessKeySecret: json["accessKeySecret"]??'',
        expiration: json["expiration"]??'',
    );

    Map<dynamic, dynamic> toJson() => {
        "accessKeyId": accessKeyId,
        "securityToken": securityToken,
        "accessKeySecret": accessKeySecret,
        "expiration": expiration,
    };
}
