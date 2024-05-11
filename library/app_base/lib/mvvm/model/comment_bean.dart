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
    required this.isMyLike,
    required this.nickName,
    required this.userAvator,
    required this.userName,
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
  bool isMyLike;
  String userName;
  String nickName;
  String userAvator;

  factory CommentList.fromJson(Map<dynamic, dynamic> json) => CommentList(
        id: json["id"] ?? '',
        parentId: json["parentId"] ?? '',
        path: json["path"] ?? '',
        sortIndex: json["sortIndex"] ?? 0,
        level: json["level"] ?? 0,
        postsId: json["postsId"] ?? '',
        content: json["content"] ?? '',
        userId: json["userId"] ?? '',
        likesNum: json["likesNum"] ?? '',
        commentsNum: json["commentsNum"] ?? '',
        isMyLike: json["isMyLike"] ?? false,
        userName: json['userName'] ?? '',
        nickName: json['nickName'] ?? '',
        userAvator: json['userAvator'] ?? '',
        creatorId: json["creatorId"] ?? '',
        modifierId: json["modifierId"] ?? '',
        modifyTime: json["modifyTime"] ?? 0,
        createTime: json["createTime"] ?? 0,
      );

  factory CommentList.mock() => CommentList(
      postsId: '123',
      likesNum: '123',
      sortIndex: 1,
      level: 1,
      creatorId: '1231',
      modifierId: '12312',
      userId: '123131',
      parentId: '13123',
      content: '好哦啊',
      path: '/',
      modifyTime: 1,
      createTime: 188899,
      id: '1213'
          '',
      commentsNum: '123',
      isMyLike: false,
      nickName: '超级赛亚人',
      userAvator: 'https://via.placeholder.com/150/0000F0/808080?Text=Image0',
      userName: '1762094255@qq.com');

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
        postsId: json["postsId"] ?? '',
        path: json["path"] ?? '',
        sortIndex: json["sortIndex"] ?? 0,
        level: json["level"] ?? 0,
        userId: json["userId"] ?? '',
        parentId: json["parentId"] ?? '',
        content: json["content"] ?? '',
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
        postsId: json["postsId"] ?? '',
        path: json["path"] ?? '',
        sortIndex: json["sortIndex"] ?? 0,
        level: json["level"] ?? 0,
        id: json["id"] ?? '',
        userId: json["userId"] ?? '',
        parentId: json["parentId"] ?? '',
        content: json["content"] ?? '',
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
