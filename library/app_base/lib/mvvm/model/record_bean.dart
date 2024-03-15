/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

RecordBean recordBeanFromJson(String str) => RecordBean.fromJson(json.decode(str));

String recordBeanToJson(RecordBean data) => json.encode(data.toJson());

class RecordBean {
    RecordBean({
        required this.dataList,
    });

    List<DataList> dataList;

    factory RecordBean.fromJson(Map<dynamic, dynamic> json) => RecordBean(
        dataList: List<DataList>.from(json["dataList"].map((x) => DataList.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "dataList": List<dynamic>.from(dataList.map((x) => x.toJson())),
    };
}

class DataList {
    DataList({
        required this.recordList,
        required this.recordName,
    });

    List<int> recordList;
    String recordName;

    factory DataList.fromJson(Map<dynamic, dynamic> json) => DataList(
        recordList: List<int>.from(json["recordList"].map((x) => x)),
        recordName: json["recordName"],
    );

    Map<dynamic, dynamic> toJson() => {
        "recordList": List<dynamic>.from(recordList.map((x) => x)),
        "recordName": recordName,
    };
}
