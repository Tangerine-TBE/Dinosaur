class HomeRsp {
    HomeRsp({
        required this.birthday,
        required this.images,
        required this.address,
        required this.gender,
        required this.nickName,
        required this.sign,
        required this.fansCount,
        required this.likeCount,
        required this.userName,
        required this.type,
        required this.voiceSign,
        required this.favorCount,
        required this.application,
        required this.phone,
        required this.organization,
        required this.avator,
        required this.id,
        required this.email,
    });

    String birthday;
    List<String> images;
    String address;
    String gender;
    String nickName;
    String sign;
    int fansCount;
    int likeCount;
    String userName;
    String type;
    String voiceSign;
    int favorCount;
    String application;
    String phone;
    String organization;
    String avator;
    String id;
    String email;

    factory HomeRsp.fromJson(Map<dynamic, dynamic> json) => HomeRsp(
        birthday: json["birthday"]??'',
        images: List<String>.from((json["images"]??[]).map((x) => x)),
        address: json["address"]??'',
        gender: json["gender"]??'',
        nickName: json["nickName"]??'',
        sign: json["sign"]??'',
        fansCount: json["fansCount"]??0,
        likeCount: json["likeCount"]??0,
        userName: json["userName"]??'',
        type: json["type"]??'',
        voiceSign: json["voiceSign"]??'',
        favorCount: json["favorCount"]??0,
        application: json["application"]??'',
        phone: json["phone"]??'',
        organization: json["organization"]??'',
        avator: json["avator"]??'',
        id: json["id"]??'',
        email: json["email"]??'',
    );

    Map<String, dynamic> toJson() => {
        "birthday": birthday,
        "images": List<dynamic>.from(images.map((x) => x)),
        "address": address,
        "gender": gender,
        "nickName": nickName,
        "sign": sign,
        "fansCount": fansCount,
        "likeCount": likeCount,
        "userName": userName,
        "type": type,
        "voiceSign": voiceSign,
        "favorCount": favorCount,
        "application": application,
        "phone": phone,
        "organization": organization,
        "avator": avator,
        "id": id,
        "email": email,
    };
}
class HomeReq{
  String id;
  HomeReq({required  this. id});
  factory HomeReq.fromJson(Map<dynamic, dynamic> json) => HomeReq(
    id: json["id"]??'',
  );
  Map<String, dynamic> toJson() => {
    "id": id,
  };



}
