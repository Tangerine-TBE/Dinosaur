import 'dart:convert';

class PushMsgReq {
  PushMsgReq({
    required this.topicId,
    required this.pageIndex,
    required this.pageSize,
    required this.orderBy,
    required this.postsType,
  });

  String topicId;
  int pageIndex;
  int pageSize;
  String orderBy;
  String postsType;

  factory PushMsgReq.fromJson(Map<dynamic, dynamic> json) => PushMsgReq(
        topicId: json["topicId"],
        pageIndex: json["pageIndex"],
        pageSize: json["pageSize"],
        orderBy: json["orderBy"],
        postsType: json["topicType"],
      );

  Map<String, dynamic> toJson() => {
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "orderBy": orderBy,
        "postsType": postsType,
      };
}

class PushMsgRsp {
  PushMsgRsp({
    required this.postsList,
  });

  List<PostsList> postsList;

  factory PushMsgRsp.fromJson(Map<dynamic, dynamic> json) => PushMsgRsp(
        postsList: List<PostsList>.from(
            json["postsList"].map((x) => PostsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "postsList": List<dynamic>.from(postsList.map((x) => x.toJson())),
      };
}

class PostsList {
  PostsList({
    required this.waves,
    required this.images,
    required this.likesNum,
    required this.creatorId,
    required this.modifierId,
    required this.favorsNum,
    required this.viewsNum,
    required this.userId,
    required this.content,
    required this.topicTitle,
    required this.topicId,
    required this.participantNum,
    required this.modifyTime,
    required this.createTime,
    required this.id,
    required this.isRecomed,
    required this.commentsNum,
    required this.isCurated,
    required this.userAvator,
    required this.userName,
  });

  List<Wave> waves;
  List<ImageString> images;
  int likesNum;
  String creatorId;
  String modifierId;
  int favorsNum;
  int viewsNum;
  String userId;
  String content;
  String topicTitle;
  String topicId;
  int participantNum;
  int modifyTime;
  int createTime;
  String id;
  String isRecomed;
  int commentsNum;
  String isCurated;
  String userAvator;
  String userName;

  factory PostsList.fromJson(Map<dynamic, dynamic> json) => PostsList(
        waves: List<Wave>.from(
            jsonDecode(json["waves"] ?? '[]').map((x) => Wave.fromJson(x))),
        images: List<ImageString>.from(jsonDecode(json["images"] ?? '[]')
            .map((x) => ImageString.fromJson(x))),
        likesNum: json["likesNum"] ?? 0,
        creatorId: json["creatorId"] ?? '',
        modifierId: json["modifierId"] ?? '',
        favorsNum: json["favorsNum"] ?? 0,
        viewsNum: json["viewsNum"] ?? 0,
        userId: json["userId"] ?? '',
        content: json["content"] ?? '',
        topicTitle: json["topicTitle"] ?? '',
        topicId: json["topicId"] ?? '',
        participantNum: json["participantNum"] ?? 0,
        modifyTime: json["modifyTime"] ?? 0,
        createTime: json["createTime"] ?? 0,
        id: json["id"] ?? '',
        isRecomed: json["isRecomed"] ?? '',
        commentsNum: json["commentsNum"] ?? 0,
        isCurated: json["isCurated"] ?? '',
        userAvator: json["userAvator"] ?? '',
        userName: json["userName"] ?? '',
      );

  Map<dynamic, dynamic> toJson() => {
        "waves": List<dynamic>.from(waves.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "likesNum": likesNum,
        "creatorId": creatorId,
        "modifierId": modifierId,
        "favorsNum": favorsNum,
        "viewsNum": viewsNum,
        "userId": userId,
        "content": content,
        "topicTitle": topicTitle,
        "topicId": topicId,
        "participantNum": participantNum,
        "modifyTime": modifyTime,
        "createTime": createTime,
        "id": id,
        "isRecomed": isRecomed,
        "commentsNum": commentsNum,
        "isCurated": isCurated,
      };
}

class ImageString {
  ImageString({
    required this.imageBase64,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  String imageBase64;
  String imageUrl;
  int width;
  int height;

  factory ImageString.fromJson(Map<dynamic, dynamic> json) => ImageString(
        imageBase64: json["imageBase64"]??'',
        imageUrl: json["imageUrl"]??'',
        width: json["width"]??0,
        height: json["height"]??0,
      );

  Map<dynamic, dynamic> toJson() => {
        "imageBase64": imageBase64,
        "imageUrl": imageUrl,
        "width": width,
        "height": height,
      };
}

class Wave {
  Wave({
    required this.id,
    required this.actions,
  });

  String id;
  String actions;

  factory Wave.fromJson(Map<dynamic, dynamic> json) => Wave(
        id: json["id"],
        actions: json["actions"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "actions": actions,
      };
}

class PushCreateReq {
  PushCreateReq({
    required this.waves,
    required this.topicId,
    required this.images,
    required this.userId,
    required this.content,
    required this.topicTitle,
  });

  List<Wave> waves;
  String topicId;
  List<ImageString> images;
  String userId;
  String content;
  String topicTitle;

  factory PushCreateReq.fromJson(Map<dynamic, dynamic> json) => PushCreateReq(
        waves: List<Wave>.from(json["waves"].map((x) => Wave.fromJson(x))),
        topicId: json["topicId"],
        images: List<ImageString>.from(
            json["images"].map((x) => ImageString.fromJson(x))),
        userId: json["userId"],
        content: json["content"],
        topicTitle: json["topicTitle"],
      );

  Map<String, dynamic> toJson() => {
        "waves": List<dynamic>.from(waves.map((x) => x.toJson())),
        "topicId": topicId,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "userId": userId,
        "content": content,
        "topicTitle": topicTitle,
      };
}
