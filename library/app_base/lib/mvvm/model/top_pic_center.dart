
class TopicCenterRsp {
  TopicCenterRsp({
    required this.topicList,
  });

  List<TopicList> topicList;

  factory TopicCenterRsp.fromJson(Map<dynamic, dynamic> json) => TopicCenterRsp(
    topicList: List<TopicList>.from(json["topicList"].map((x) => TopicList.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "topicList": List<dynamic>.from(topicList.map((x) => x.toJson())),
  };
}

class TopicCenterReq {
  TopicCenterReq({
    required this.orderBy,
  });

  String orderBy;

  factory TopicCenterReq.fromJson(Map<dynamic, dynamic> json) => TopicCenterReq(
    orderBy: json["orderBy"],
  );

  Map<String, dynamic> toJson() => {
    "orderBy": orderBy,
  };
}

class TopicList {
  TopicList({
    required this.icon,
    required this.creatorId,
    required this.modifierId,
    required this.deletedId,
    required this.title,
    required this.content,
    required this.modifyTime,
    required this.isDeleted,
    required this.createTime,
    required this.subtitle,
    required this.appId,
    required this.tenantId,
    required this.checksum,
    required this.id,
    required this.deletedTime,
  });

  String icon;
  String creatorId;
  String modifierId;
  String deletedId;
  String title;
  String content;
  int modifyTime;
  String isDeleted;
  int createTime;
  String subtitle;
  String appId;
  String tenantId;
  String checksum;
  String id;
  String deletedTime;

  factory TopicList.fromJson(Map<dynamic, dynamic> json) => TopicList(
    icon: json["icon"]??'',
    creatorId: json["creatorId"]??'',
    modifierId: json["modifierId"]??'',
    deletedId: json["deletedId"]??'',
    title: json["title"]??'',
    content: json["content"]??'',
    modifyTime: json["modifyTime"]??0,
    isDeleted: json["isDeleted"]??'',
    createTime: json["createTime"]??0,
    subtitle: json["subtitle"]??'',
    appId: json["appId"]??'',
    tenantId: json["tenantId"]??'',
    checksum: json["checksum"]??'',
    id: json["id"]??'',
    deletedTime: json["deletedTime"]??'',
  );

  Map<dynamic, dynamic> toJson() => {
    "icon": icon,
    "creatorId": creatorId,
    "modifierId": modifierId,
    "deletedId": deletedId,
    "title": title,
    "content": content,
    "modifyTime": modifyTime,
    "isDeleted": isDeleted,
    "createTime": createTime,
    "subtitle": subtitle,
    "appId": appId,
    "tenantId": tenantId,
    "checksum": checksum,
    "id": id,
    "deletedTime": deletedTime,
  };
}


class TopiCenterCreateReq {
  TopiCenterCreateReq({
    required this.subtitle,
    required this.icon,
    required this.title,
    required this.content,
  });

  String subtitle;
  String icon;
  String title;
  String content;

  factory TopiCenterCreateReq.fromJson(Map<dynamic, dynamic> json) => TopiCenterCreateReq(
    subtitle: json["subtitle"]??'',
    icon: json["icon"]??'',
    title: json["title"]??'',
    content: json["content"]??'',
  );

  Map<String , dynamic> toJson() => {
    "subtitle": subtitle,
    "icon": icon,
    "title": title,
    "content": content,
  };
}

class TopiCenterCreateRsp {
  TopiCenterCreateRsp({
    required this.isDeleted,
    required this.createTime,
    required this.subtitle,
    required this.icon,
    required this.creatorId,
    required this.checksum,
    required this.id,
    required this.title,
    required this.content,
  });

  String isDeleted;
  int createTime;
  String subtitle;
  String icon;
  String creatorId;
  String checksum;
  String id;
  String title;
  String content;

  factory TopiCenterCreateRsp.fromJson(Map<dynamic, dynamic> json) => TopiCenterCreateRsp(
    isDeleted: json["isDeleted"]??'',
    createTime: json["createTime"]??'',
    subtitle: json["subtitle"]??'',
    icon: json["icon"]??'',
    creatorId: json["creatorId"]??'',
    checksum: json["checksum"]??'',
    id: json["id"]??'',
    title: json["title"]??'',
    content: json["content"]??'',
  );

  Map<String, dynamic> toJson() => {
    "isDeleted": isDeleted,
    "createTime": createTime,
    "subtitle": subtitle,
    "icon": icon,
    "creatorId": creatorId,
    "checksum": checksum,
    "id": id,
    "title": title,
    "content": content,
  };
}