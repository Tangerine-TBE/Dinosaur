/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
    Test({
        required this.recommon,
    });

    List<Recommon> recommon;

    factory Test.fromJson(Map<dynamic, dynamic> json) => Test(
        recommon: List<Recommon>.from(json["recommon"].map((x) => Recommon.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "recommon": List<dynamic>.from(recommon.map((x) => x.toJson())),
    };
}

class Recommon {
    Recommon({
        required this.viewNum,
        required this.avatar,
        required this.id,
        required this.userName,
        required this.content,
        required this.title,
        required this.likeNUm,
    });

    String viewNum;
    String avatar;
    String id;
    String userName;
    String content;
    String title;
    String likeNUm;

    factory Recommon.fromJson(Map<dynamic, dynamic> json) => Recommon(
        viewNum: json["viewNum"],
        avatar: json["avatar"],
        id: json["id"],
        userName: json["userName"],
        content: json["content"],
        title: json["#Title"],
        likeNUm: json["likeNUm"],
    );

    Map<dynamic, dynamic> toJson() => {
        "viewNum": viewNum,
        "avatar": avatar,
        "id": id,
        "userName": userName,
        "content": content,
        "#Title": title,
        "likeNUm": likeNUm,
    };
}
