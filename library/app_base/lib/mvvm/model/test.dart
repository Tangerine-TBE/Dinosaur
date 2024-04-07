/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
    Test({
        required this.waveList,
    });

    List<WaveList> waveList;

    factory Test.fromJson(Map<dynamic, dynamic> json) => Test(
        waveList: List<WaveList>.from(json["waveList"].map((x) => WaveList.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "waveList": List<dynamic>.from(waveList.map((x) => x.toJson())),
    };
}

class WaveList {
    WaveList({
        required this.likesNum,
        required this.creatorId,
        required this.modifierId,
        required this.description,
        required this.favorsNum,
        required this.type,
        required this.viewsNum,
        required this.userId,
        required this.tags,
        required this.kcal,
        required this.modifyTime,
        required this.createTime,
        required this.appId,
        required this.name,
        required this.tenantId,
        required this.id,
        required this.attribute,
        required this.actions,
        required this.commentsNum,
    });

    int likesNum;
    String creatorId;
    String modifierId;
    String description;
    int favorsNum;
    String type;
    int viewsNum;
    String userId;
    String tags;
    double kcal;
    int modifyTime;
    int createTime;
    String appId;
    String name;
    String tenantId;
    String id;
    String attribute;
    String actions;
    int commentsNum;

    factory WaveList.fromJson(Map<dynamic, dynamic> json) => WaveList(
        likesNum: json["likesNum"],
        creatorId: json["creatorId"],
        modifierId: json["modifierId"],
        description: json["description"],
        favorsNum: json["favorsNum"],
        type: json["type"],
        viewsNum: json["viewsNum"],
        userId: json["userId"],
        tags: json["tags"],
        kcal: json["kcal"]?.toDouble(),
        modifyTime: json["modifyTime"],
        createTime: json["createTime"],
        appId: json["appId"],
        name: json["name"],
        tenantId: json["tenantId"],
        id: json["id"],
        attribute: json["attribute"],
        actions: json["actions"],
        commentsNum: json["commentsNum"],
    );

    Map<dynamic, dynamic> toJson() => {
        "likesNum": likesNum,
        "creatorId": creatorId,
        "modifierId": modifierId,
        "description": description,
        "favorsNum": favorsNum,
        "type": type,
        "viewsNum": viewsNum,
        "userId": userId,
        "tags": tags,
        "kcal": kcal,
        "modifyTime": modifyTime,
        "createTime": createTime,
        "appId": appId,
        "name": name,
        "tenantId": tenantId,
        "id": id,
        "attribute": attribute,
        "actions": actions,
        "commentsNum": commentsNum,
    };
}
