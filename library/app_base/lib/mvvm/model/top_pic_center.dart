
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
    likesNum: json["likesNum"]??0,
    creatorId: json["creatorId"]??"",
    modifierId: json["modifierId"]??'',
    favorsNum: json["favorsNum"]??0,
    deletedId: json["deletedId"]??'',
    title: json["title"]??'',
    viewsNum: json["viewsNum"]??0,
    content: json["content"]??'',
    participantNum: json["participantNum"]??0,
    modifyTime: json["modifyTime"]??0,
    isDeleted: json["isDeleted"]??'',
    createTime: json["createTime"]??0,
    subtitle: json["subtitle"]??'',
    imageUrl: json["imageUrl"]??'',
    appId: json["appId"]??'',
    tenantId: json["tenantId"]??'',
    id: json["id"]??'',
    iconUrl: json["iconUrl"]??'',
    deletedTime: json["deletedTime"]??'',
    commentsNum: json["commentsNum"]??0,
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