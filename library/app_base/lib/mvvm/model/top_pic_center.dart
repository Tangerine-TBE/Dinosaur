/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation
library;

import 'dart:convert';

TopPicCenterBean topPicBeanFromJson(String str) =>
    TopPicCenterBean.fromJson(json.decode(str));

String topPicBeanToJson(TopPicCenterBean data) => json.encode(data.toJson());

class TopPicCenterBean {
  TopPicCenterBean({
    required this.date,
    required this.imgUrl,
    required this.preTitle,
    required this.subTitle,
    required this.title,
  });

  String date;
  String imgUrl;
  String preTitle;
  String subTitle;
  String title;

  factory TopPicCenterBean.fromJson(Map<dynamic, dynamic> json) =>
      TopPicCenterBean(
        date: json["date"],
        imgUrl: json["imgUrl"],
        preTitle: json["preTitle"],
        subTitle: json["subTitle"],
        title: json["title"],
      );

  factory TopPicCenterBean.mock(){
    return TopPicCenterBean(date: '2024/3/4',
        imgUrl: 'https://via.placeholder.com/150/0000FF/808080?Text=FirstImage',
        preTitle: '说说你对2024的展望',
        subTitle: '2024我劝你善良',
        title: '#2024愿景');
  }


  Map<dynamic, dynamic> toJson() =>
      {
        "date": date,
        "imgUrl": imgUrl,
        "preTitle": preTitle,
        "subTitle": subTitle,
        "title": title,
      };
}
