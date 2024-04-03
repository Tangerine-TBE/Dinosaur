/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation
library;

class RecordReq {
    RecordReq({
        required this.kcal,
        required this.name,
        required this.description,
        required this.attribute,
        required this.type,
        required this.actions,
        required this.userId,
        required this.tags,
    });

    double kcal;
    String name;
    String description;
    String attribute;
    String type;
    Data actions;
    String userId;
    String tags;

    Map<String, dynamic> toJson() => {
        "kcal": kcal,
        "name": name,
        "description": description,
        "attribute": attribute,
        "type": type,
        "actions": actions.toJson(),
        "userId": userId,
        "tags": tags,
    };
}

class Data {
    Data({
        required this.record,
    });
    List<int> record;
    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        record: List<int>.from(json["record"].map((x) => x)),
    );
    Map<dynamic, dynamic> toJson() => {
        "record": List<dynamic>.from(record.map((x) => x)),
    };
}

class ModelReq{
    ModelReq({
        required this.orderBy,
        required this.userId,
    });

    String orderBy;
    String userId;

    factory ModelReq.fromJson(Map<dynamic, dynamic> json) => ModelReq(
        orderBy: json["orderBy"],
        userId: json["userId"],
    );
    Map<String, dynamic> toJson() => {
        "orderBy": orderBy,
        "userId": userId,
    };
}
class ModelRsp {
    ModelRsp({
        required this.modeList,
    });

    List<ModeList> modeList;

    factory ModelRsp.fromJson(Map<dynamic, dynamic> json) => ModelRsp(
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
    Data actions;

    factory ModeList.fromJson(Map<dynamic, dynamic> json) => ModeList(
        creatorId: json["creatorId"]??'',
        description: json["description"]??'',
        type: json["type"]??'',
        userId: json["userId"]??'',
        tags: json["tags"]??'',
        kcal: json["kcal"]?.toDouble()??'',
        createTime: json["createTime"]??0,
        appId: json["appId"]??'',
        name: json["name"]??'',
        tenantId: json["tenantId"]??'',
        id: json["id"]??'',
        attribute: json["attribute"]??'',
        actions: Data.fromJson(json["actions"]),
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
        "actions": actions.toJson(),
    };
}
