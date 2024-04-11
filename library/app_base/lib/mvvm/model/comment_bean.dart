class CommentListReq {
  CommentListReq({
    required this.postsId,
    required this.pageIndex,
    required this.pageSize,
    required this.orderBy,
  });

  String postsId;
  int pageIndex;
  int pageSize;
  String orderBy;

  factory CommentListReq.fromJson(Map<dynamic, dynamic> json) => CommentListReq(
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

class CommentListRsp {
  CommentListRsp({
    required this.commentList,
  });

  List<CommentList> commentList;

  factory CommentListRsp.fromJson(Map<dynamic, dynamic> json) => CommentListRsp(
        commentList: List<CommentList>.from(
            json["commentList"].map((x) => CommentList.fromJson(x))),
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
        postsId: json["postsId"]??'',
        likesNum: json["likesNum"]??'',
        sortIndex: json["sortIndex"]??0,
        level: json["level"]??0,
        creatorId: json["creatorId"]??'',
        modifierId: json["modifierId"]??'',
        userId: json["userId"]??'',
        parentId: json["parentId"]??'',
        content: json["content"]??'',
        path: json["path"]??'',
        modifyTime: json["modifyTime"]??0,
        createTime: json["createTime"]??0,
        id: json["id"]??'',
        commentsNum: json["commentsNum"]??'',
      );
  factory CommentList.mock()=>CommentList(postsId: '123', likesNum: '123', sortIndex: 1, level: 1, creatorId: '1231', modifierId: '12312', userId: '123131', parentId: '13123', content: '好哦啊', path: '/', modifyTime: 1, createTime: 188899, id: '1213'
      '', commentsNum: '123');

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

class CommentCreateReq {
  CommentCreateReq({
    required this.postsId,
    required this.path,
    required this.sortIndex,
    required this.level,
    required this.userId,
    required this.parentId,
    required this.content,
  });

  String postsId;
  String path;
  int sortIndex;
  int level;
  String userId;
  String parentId;
  String content;

  factory CommentCreateReq.fromJson(Map<dynamic, dynamic> json) =>
      CommentCreateReq(
        postsId: json["postsId"]??'',
        path: json["path"]??'',
        sortIndex: json["sortIndex"]??0,
        level: json["level"]??0,
        userId: json["userId"]??'',
        parentId: json["parentId"]??'',
        content: json["content"]??'',
      );

  Map<String, dynamic> toJson() => {
        "postsId": postsId,
        "path": path,
        "sortIndex": sortIndex,
        "level": level,
        "userId": userId,
        "parentId": parentId,
        "content": content,
      };
}

class CommentCreateRsp {
  CommentCreateRsp({
    required this.postsId,
    required this.path,
    required this.sortIndex,
    required this.level,
    required this.id,
    required this.userId,
    required this.parentId,
    required this.content,
  });

  String postsId;
  String path;
  int sortIndex;
  int level;
  String id;
  String userId;
  String parentId;
  String content;

  factory CommentCreateRsp.fromJson(Map<dynamic, dynamic> json) =>
      CommentCreateRsp(
        postsId: json["postsId"]??'',
        path: json["path"]??'',
        sortIndex: json["sortIndex"]??0,
        level: json["level"]??0,
        id: json["id"]??'',
        userId: json["userId"]??'',
        parentId: json["parentId"]??'',
        content: json["content"]??'',
      );

  Map<String, dynamic> toJson() => {
        "postsId": postsId,
        "path": path,
        "sortIndex": sortIndex,
        "level": level,
        "id": id,
        "userId": userId,
        "parentId": parentId,
        "content": content,
      };
}
