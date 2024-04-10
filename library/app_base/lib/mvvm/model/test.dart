/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
    Test({
        required this.commentList,
    });

    List<CommentList> commentList;

    factory Test.fromJson(Map<dynamic, dynamic> json) => Test(
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
