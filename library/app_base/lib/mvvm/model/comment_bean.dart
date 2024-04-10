
class CommentReq {
  CommentReq({
    required this.postsId,
    required this.pageIndex,
    required this.pageSize,
    required this.orderBy,
  });

  String postsId;
  int pageIndex;
  int pageSize;
  String orderBy;

  factory CommentReq.fromJson(Map<dynamic, dynamic> json) => CommentReq(
    postsId: json["postsId"],
    pageIndex: json["pageIndex"],
    pageSize: json["pageSize"],
    orderBy: json["orderBy"],
  );

  Map<String, dynamic> toJson() => {
    "postsId": postsId,
    "pageIndex": pageIndex,
    "pageSize": pageSize,
    "orderBy": orderBy,
  };
}

class CommentRsp {
  CommentRsp({
    required this.commentList,
  });

  List<CommentList> commentList;

  factory CommentRsp.fromJson(Map<dynamic, dynamic> json) => CommentRsp(
    commentList: List<CommentList>.from(json["commentList"].map((x) => CommentList.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "commentList": List<dynamic>.from(commentList.map((x) => x.toJson())),
  };
}

class CommentList {
  CommentList({
    required this.postsId,
    required this.likesNum,
    required this.sortIndex,
    required this.level,
    required this.creatorId,
    required this.modifierId,
    required this.userId,
    required this.parentId,
    required this.content,
    required this.path,
    required this.modifyTime,
    required this.createTime,
    required this.id,
    required this.commentsNum,
  });

  String postsId;
  String likesNum;
  int sortIndex;
  int level;
  String creatorId;
  String modifierId;
  String userId;
  String parentId;
  String content;
  String path;
  int modifyTime;
  int createTime;
  String id;
  String commentsNum;

  factory CommentList.fromJson(Map<dynamic, dynamic> json) => CommentList(
    postsId: json["postsId"],
    likesNum: json["likesNum"],
    sortIndex: json["sortIndex"],
    level: json["level"],
    creatorId: json["creatorId"],
    modifierId: json["modifierId"],
    userId: json["userId"],
    parentId: json["parentId"],
    content: json["content"],
    path: json["path"],
    modifyTime: json["modifyTime"],
    createTime: json["createTime"],
    id: json["id"],
    commentsNum: json["commentsNum"],
  );

  Map<dynamic, dynamic> toJson() => {
    "postsId": postsId,
    "likesNum": likesNum,
    "sortIndex": sortIndex,
    "level": level,
    "creatorId": creatorId,
    "modifierId": modifierId,
    "userId": userId,
    "parentId": parentId,
    "content": content,
    "path": path,
    "modifyTime": modifyTime,
    "createTime": createTime,
    "id": id,
    "commentsNum": commentsNum,
  };
}
