/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

CharModel charModelFromJson(String str) => CharModel.fromJson(json.decode(str));

String charModelToJson(CharModel data) => json.encode(data.toJson());

class CharModel {
    CharModel({
        required this.waveList,
    });

    List<WaveList> waveList;

    factory CharModel.fromJson(Map<dynamic, dynamic> json) => CharModel(
        waveList: List<WaveList>.from(json["waveList"].map((x) => WaveList.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "waveList": List<dynamic>.from(waveList.map((x) => x.toJson())),
    };
}

class WaveList {
    WaveList({
        required this.likesNum,
        required this.icon,
        required this.creatorId,
        required this.modifierId,
        required this.description,
        required this.deletedId,
        required this.viewsNum,
        required this.kcal,
        required this.bookmarksNum,
        required this.modifyTime,
        required this.isDeleted,
        required this.createTime,
        required this.imageUrl,
        required this.appId,
        required this.name,
        required this.tenantId,
        required this.checksum,
        required this.id,
        required this.attribute,
        required this.deletedTime,
        required this.actions,
        required this.commentsNum,
    });

    String likesNum;
    String icon;
    String creatorId;
    String modifierId;
    String description;
    String deletedId;
    String viewsNum;
    double kcal;
    String bookmarksNum;
    int modifyTime;
    String isDeleted;
    int createTime;
    String imageUrl;
    String appId;
    String name;
    String tenantId;
    String checksum;
    String id;
    String attribute;
    String deletedTime;
    String actions;
    String commentsNum;

    factory WaveList.fromJson(Map<dynamic, dynamic> json) => WaveList(
        likesNum: json["likesNum"]??'',
        icon: json["icon"]??'',
        creatorId: json["creatorId"]??'',
        modifierId: json["modifierId"]??'',
        description: json["description"]??'',
        deletedId: json["deletedId"]??'',
        viewsNum: json["viewsNum"]??'',
        kcal: json["kcal"]?.toDouble()??0.0,
        bookmarksNum: json["bookmarksNum"]??'',
        modifyTime: json["modifyTime"]??0,
        isDeleted: json["isDeleted"]??'',
        createTime: json["createTime"]??0,
        imageUrl: json["imageUrl"],
        appId: json["appId"]??'',
        name: json["name"]??'',
        tenantId: json["tenantId"]??'',
        checksum: json["checksum"]??'',
        id: json["id"]??'',
        attribute: json["attribute"]??'',
        deletedTime: json["deletedTime"]??'',
        actions: json["actions"]??'',
        commentsNum: json["commentsNum"]??'',
    );

    Map<dynamic, dynamic> toJson() => {
        "likesNum": likesNum,
        "icon": icon,
        "creatorId": creatorId,
        "modifierId": modifierId,
        "description": description,
        "deletedId": deletedId,
        "viewsNum": viewsNum,
        "kcal": kcal,
        "bookmarksNum": bookmarksNum,
        "modifyTime": modifyTime,
        "isDeleted": isDeleted,
        "createTime": createTime,
        "imageUrl": imageUrl,
        "appId": appId,
        "name": name,
        "tenantId": tenantId,
        "checksum": checksum,
        "id": id,
        "attribute": attribute,
        "deletedTime": deletedTime,
        "actions": actions,
        "commentsNum": commentsNum,
    };
}

class SingleWave{
    int type=1;
    List<int> data;
    SingleWave({required this.data});
    factory SingleWave.fromJson(Map<dynamic,dynamic> map) => SingleWave(data: map["data"]??<int>[]);
}
class DoubleWave{

}
class SpecialWave{

}
