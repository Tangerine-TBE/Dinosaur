/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

import 'comment_bean.dart';

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

