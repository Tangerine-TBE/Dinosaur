import 'dart:convert';

class ChartRsp {
  ChartRsp({
    required this.waveList,
  });

  List<WaveList> waveList;

  factory ChartRsp.fromJson(Map<dynamic, dynamic> json) => ChartRsp(
        waveList: List<WaveList>.from(
            json["waveList"].map((x) => WaveList.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "waveList": List<dynamic>.from(waveList.map((x) => x.toJson())),
      };
}

class ChartReq {
  ChartReq({
    required this.pageIndex,
    required this.pageSize,
    required this.orderBy,
    required this.type,
  });

  int pageIndex;
  int pageSize;
  String orderBy;
  String type;

  factory ChartReq.fromJson(Map<dynamic, dynamic> json) => ChartReq(
        pageIndex: json["pageIndex"],
        pageSize: json["pageSize"],
        orderBy: json["orderBy"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "orderBy": orderBy,
        "type": type,
      };
}

class ChartCreateReq {
  ChartCreateReq({
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
  String actions;
  String userId;
  String tags;

  factory ChartCreateReq.fromJson(Map<dynamic, dynamic> json) => ChartCreateReq(
        kcal: json["kcal"]?.toDouble(),
        name: json["name"],
        description: json["description"],
        attribute: json["attribute"],
        type: json["type"],
        actions: json["actions"],
        userId: json["userId"],
        tags: json["tags"],
      );

  Map<String, dynamic> toJson() => {
        "kcal": kcal,
        "name": name,
        "description": description,
        "attribute": attribute,
        "type": type,
        "actions": actions,
        "userId": userId,
        "tags": tags,
      };
}

class WaveList {
  WaveList({
    required this.id,
    required this.name,
    required this.attribute,
    required this.description,
    required this.actions,
    required this.kcal,
    required this.type,
    required this.tags,
    required this.userId,
    required this.viewsNum,
    required this.likesNum,
    required this.commentsNum,
    required this.favorsNum,
    required this.appId,
    required this.tenantId,
    required this.creatorId,
    required this.createTime,
    required this.modifierId,
    required this.modifyTime,
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
    likesNum: json["likesNum"]??0,
    creatorId: json["creatorId"]??'',
    modifierId: json["modifierId"]??'',
    description: json["description"]??'',
    favorsNum: json["favorsNum"]??0,
    type: json["type"]??'',
    viewsNum: json["viewsNum"]??0,
    userId: json["userId"]??'',
    tags: json["tags"]??'',
    kcal: json["kcal"]?.toDouble()??0.0,
    modifyTime: json["modifyTime"]??0,
    createTime: json["createTime"]??0,
    appId: json["appId"]??'',
    name: json["name"]??'',
    tenantId: json["tenantId"]??'',
    id: json["id"]??'',
    attribute: json["attribute"]??'',
    actions: json["actions"]??'',
    commentsNum: json["commentsNum"]??0,
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

class SingleWave {
  List<int> data;

  SingleWave({required this.data});

  factory SingleWave.fromJson(Map<dynamic, dynamic> map) {
    List<dynamic> dynamicList = map["record"];
    List<int> intList = dynamicList.map((e) => e as int).toList();
    return SingleWave(data: intList);
  }
}

class DoubleWave {
  List<int> data1;
  List<int> data2;

  DoubleWave({required this.data1, required this.data2});

  factory DoubleWave.fromJson(Map<dynamic, dynamic> map) {
    List<dynamic> dynamicList = map["record"]??'';
    List<int> intList = dynamicList.map((e) => e as int).toList();
    return DoubleWave(data1: intList,data2: intList);
  }
}

class SpecialWave {
  List<int> data;

  SpecialWave({required this.data});

  factory SpecialWave.fromJson(Map<dynamic, dynamic> map) {
    List<dynamic> dynamicList = map["record"];
    List<int> intList = dynamicList.map((e) => e as int).toList();
    return SpecialWave(data: intList);
  }
}
