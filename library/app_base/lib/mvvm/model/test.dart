/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
    Test({
        required this.topicList,
    });

    List<TopicList> topicList;

    factory Test.fromJson(Map<dynamic, dynamic> json) => Test(
        topicList: List<TopicList>.from(json["topicList"].map((x) => TopicList.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "topicList": List<dynamic>.from(topicList.map((x) => x.toJson())),
    };
}

class TopicList {
    TopicList({
        required this.likesNum,
        required this.creatorId,
        required this.modifierId,
        required this.favorsNum,
        required this.deletedId,
        required this.title,
        required this.viewsNum,
        required this.content,
        required this.participantNum,
        required this.modifyTime,
        required this.isDeleted,
        required this.createTime,
        required this.subtitle,
        required this.imageUrl,
        required this.appId,
        required this.tenantId,
        required this.id,
        required this.iconUrl,
        required this.deletedTime,
        required this.commentsNum,
    });

    int likesNum;
    String creatorId;
    String modifierId;
    int favorsNum;
    String deletedId;
    String title;
    int viewsNum;
    String content;
    int participantNum;
    int modifyTime;
    String isDeleted;
    int createTime;
    String subtitle;
    String imageUrl;
    String appId;
    String tenantId;
    String id;
    String iconUrl;
    String deletedTime;
    int commentsNum;

    factory TopicList.fromJson(Map<dynamic, dynamic> json) => TopicList(
        likesNum: json["likesNum"],
        creatorId: json["creatorId"],
        modifierId: json["modifierId"],
        favorsNum: json["favorsNum"],
        deletedId: json["deletedId"],
        title: json["title"],
        viewsNum: json["viewsNum"],
        content: json["content"],
        participantNum: json["participantNum"],
        modifyTime: json["modifyTime"],
        isDeleted: json["isDeleted"],
        createTime: json["createTime"],
        subtitle: json["subtitle"],
        imageUrl: json["imageUrl"],
        appId: json["appId"],
        tenantId: json["tenantId"],
        id: json["id"],
        iconUrl: json["iconUrl"],
        deletedTime: json["deletedTime"],
        commentsNum: json["commentsNum"],
    );

    Map<dynamic, dynamic> toJson() => {
        "likesNum": likesNum,
        "creatorId": creatorId,
        "modifierId": modifierId,
        "favorsNum": favorsNum,
        "deletedId": deletedId,
        "title": title,
        "viewsNum": viewsNum,
        "content": content,
        "participantNum": participantNum,
        "modifyTime": modifyTime,
        "isDeleted": isDeleted,
        "createTime": createTime,
        "subtitle": subtitle,
        "imageUrl": imageUrl,
        "appId": appId,
        "tenantId": tenantId,
        "id": id,
        "iconUrl": iconUrl,
        "deletedTime": deletedTime,
        "commentsNum": commentsNum,
    };
}
