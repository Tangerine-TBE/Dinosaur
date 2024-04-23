import 'package:app_base/mvvm/model/push_bean.dart';

import 'comment_bean.dart';

class MineReq {
  MineReq({
    required this.topicId,
    required this.pageIndex,
    required this.pageSize,
    required this.orderBy,
    required this.topicType,
  });

  String topicId;
  int pageIndex;
  int pageSize;
  String orderBy;
  String topicType;

  factory MineReq.fromJson(Map<dynamic, dynamic> json) => MineReq(
        topicId: json["topicId"] ?? '',
        pageIndex: json["pageIndex"] ?? 0,
        pageSize: json["pageSize"] ?? 0,
        orderBy: json["orderBy"] ?? '',
        topicType: json["topicType"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "topicId": topicId,
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "orderBy": orderBy,
        "topicType": topicType,
      };
}

class MineRsq {
  MineRsq({
    required this.postsList,
  });

  List<PostsList> postsList;

  factory MineRsq.fromJson(Map<dynamic, dynamic> json) => MineRsq(
    postsList: List<PostsList>.from(json["postsList"]??[].map((x) => PostsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "postsList": List<dynamic>.from(postsList.map((x) => x.toJson())),
  };
}

class MineCommentRsq {
  MineCommentRsq({
    required this.postsId,
    required this.pageIndex,
    required this.pageSize,
    required this.orderBy,
  });

  String postsId;
  int pageIndex;
  int pageSize;
  String orderBy;

  factory MineCommentRsq.fromJson(Map<dynamic, dynamic> json) => MineCommentRsq(
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

class MineCommentRsp {
  MineCommentRsp({
    required this.commentList,
  });

  List<CommentList> commentList;

  factory MineCommentRsp.fromJson(Map<dynamic, dynamic> json) => MineCommentRsp(
    commentList: List<CommentList>.from(json["commentList"].map((x) => CommentList.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "commentList": List<dynamic>.from(commentList.map((x) => x.toJson())),
  };
}
