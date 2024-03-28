/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

Adasd adasdFromJson(String str) => Adasd.fromJson(json.decode(str));

String adasdToJson(Adasd data) => json.encode(data.toJson());

class Adasd {
    Adasd({
        required this.dataList,
    });

    List<DataList> dataList;

    factory Adasd.fromJson(Map<dynamic, dynamic> json) => Adasd(
        dataList: List<DataList>.from(json["dataList"].map((x) => DataList.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "dataList": List<dynamic>.from(dataList.map((x) => x.toJson())),
    };
}

class DataList {
    DataList({
        required this.kcal,
        required this.data,
        required this.timeAdvice,
        required this.link,
        required this.userName,
        required this.likeNum,
    });

    String kcal;
    List<int> data;
    String timeAdvice;
    bool link;
    String userName;
    String likeNum;

    factory DataList.fromJson(Map<dynamic, dynamic> json) => DataList(
        kcal: json["kcal"],
        data: List<int>.from(json["data"].map((x) => x)),
        timeAdvice: json["timeAdvice"],
        link: json["link"],
        userName: json["userName"],
        likeNum: json["likeNum"],
    );

    Map<dynamic, dynamic> toJson() => {
        "kcal": kcal,
        "data": List<dynamic>.from(data.map((x) => x)),
        "timeAdvice": timeAdvice,
        "link": link,
        "userName": userName,
        "likeNum": likeNum,
    };
}
