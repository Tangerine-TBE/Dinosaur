/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
    Test({
        required this.waves,
        required this.topicId,
        required this.images,
        required this.userId,
        required this.content,
        required this.topicTitle,
    });

    List<Wave> waves;
    String topicId;
    List<Image> images;
    String userId;
    String content;
    String topicTitle;

    factory Test.fromJson(Map<dynamic, dynamic> json) => Test(
        waves: List<Wave>.from(json["waves"].map((x) => Wave.fromJson(x))),
        topicId: json["topicId"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        userId: json["userId"],
        content: json["content"],
        topicTitle: json["topicTitle"],
    );

    Map<dynamic, dynamic> toJson() => {
        "waves": List<dynamic>.from(waves.map((x) => x.toJson())),
        "topicId": topicId,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "userId": userId,
        "content": content,
        "topicTitle": topicTitle,
    };
}

class Image {
    Image({
        required this.imageBase64,
        required this.imageUrl,
    });

    String imageBase64;
    String imageUrl;

    factory Image.fromJson(Map<dynamic, dynamic> json) => Image(
        imageBase64: json["imageBase64"],
        imageUrl: json["imageUrl"],
    );

    Map<dynamic, dynamic> toJson() => {
        "imageBase64": imageBase64,
        "imageUrl": imageUrl,
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
