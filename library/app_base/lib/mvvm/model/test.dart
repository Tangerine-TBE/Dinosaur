/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
    Test({
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

    factory Test.fromJson(Map<dynamic, dynamic> json) => Test(
        postsId: json["postsId"],
        path: json["path"],
        sortIndex: json["sortIndex"],
        level: json["level"],
        id: json["id"],
        userId: json["userId"],
        parentId: json["parentId"],
        content: json["content"],
    );

    Map<dynamic, dynamic> toJson() => {
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
