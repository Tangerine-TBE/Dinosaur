/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
    Test({
        required this.modeList,
    });

    List<ModeList> modeList;

    factory Test.fromJson(Map<dynamic, dynamic> json) => Test(
        modeList: List<ModeList>.from(json["modeList"].map((x) => ModeList.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "modeList": List<dynamic>.from(modeList.map((x) => x.toJson())),
    };
}

class ModeList {
    ModeList({
        required this.creatorId,
        required this.description,
        required this.type,
        required this.userId,
        required this.tags,
        required this.kcal,
        required this.createTime,
        required this.appId,
        required this.name,
        required this.tenantId,
        required this.id,
        required this.attribute,
        required this.actions,
    });

    String creatorId;
    String description;
    String type;
    String userId;
    String tags;
    double kcal;
    int createTime;
    String appId;
    String name;
    String tenantId;
    String id;
    String attribute;
    String actions;

    factory ModeList.fromJson(Map<dynamic, dynamic> json) => ModeList(
        creatorId: json["creatorId"],
        description: json["description"],
        type: json["type"],
        userId: json["userId"],
        tags: json["tags"],
        kcal: json["kcal"]?.toDouble(),
        createTime: json["createTime"],
        appId: json["appId"],
        name: json["name"],
        tenantId: json["tenantId"],
        id: json["id"],
        attribute: json["attribute"],
        actions: json["actions"],
    );

    Map<dynamic, dynamic> toJson() => {
        "creatorId": creatorId,
        "description": description,
        "type": type,
        "userId": userId,
        "tags": tags,
        "kcal": kcal,
        "createTime": createTime,
        "appId": appId,
        "name": name,
        "tenantId": tenantId,
        "id": id,
        "attribute": attribute,
        "actions": actions,
    };
}
