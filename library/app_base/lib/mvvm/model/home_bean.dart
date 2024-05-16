class HomeRsp {
  HomeRsp({
    required this.birthday,
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
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
  });

  String birthday;
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
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;

  factory HomeRsp.fromJson(Map<dynamic, dynamic> json) => HomeRsp(
        birthday: json["birthday"] ?? '',
        address: json["address"] ?? '',
        gender: json["gender"] ?? '',
        nickName: json["nickName"] ?? '',
        sign: json["sign"] ?? '',
        fansCount: json["fansCount"] ?? 0,
        likeCount: json["likeCount"] ?? 0,
        userName: json["userName"] ?? '',
        type: json["type"] ?? '',
        voiceSign: json["voiceSign"] ?? '',
        favorCount: json["favorCount"] ?? 0,
        application: json["application"] ?? '',
        phone: json["phone"] ?? '',
        organization: json["organization"] ?? '',
        avator: json["avator"] ?? '',
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        image1: json['image1'] ?? '',
        image2: json['image2'] ?? '',
        image3: json['image3'] ?? '',
        image4: json['image4'] ?? '',
        image5: json['image5'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "birthday": birthday,
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
        "image1":image1,
    "image2":image2,
    "image3":image3,
    "image4":image4,
    "image5":image5,

      };
}

class HomeReq {
  String id;

  HomeReq({required this.id});

  factory HomeReq.fromJson(Map<dynamic, dynamic> json) => HomeReq(
        id: json["id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
