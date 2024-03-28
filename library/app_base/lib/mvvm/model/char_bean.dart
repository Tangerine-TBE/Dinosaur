import 'dart:math';

class CharSingleBean {
  CharSingleBean({
    required this.dataList,
  });

  List<SingleList> dataList;

  factory CharSingleBean.mock() =>
      CharSingleBean(dataList: List.generate(10, (index) => SingleList.mock()));
}

class CharDoubleBean {
  CharDoubleBean({
    required this.dataList,
  });

  List<DoubleList> dataList;

  factory CharDoubleBean.mock() =>
      CharDoubleBean(dataList: List.generate(10, (index) => DoubleList.mock()));

  Map<dynamic, dynamic> toJson() => {
        "dataList": List<dynamic>.from(dataList.map((x) => x.toJson())),
      };
}

class CharSpecialBean {
  CharSpecialBean({
    required this.dataList,
  });

  List<SpecialList> dataList;

  factory CharSpecialBean.mock() => CharSpecialBean(
      dataList: List.generate(10, (index) => SpecialList.mock()));

  Map<dynamic, dynamic> toJson() => {
        "dataList": List<dynamic>.from(dataList.map((x) => x.toJson())),
      };
}

class SingleList {
  SingleList(
      {required this.kcal,
      required this.data,
      required this.timeAdvice,
      required this.link,
      required this.userName,
      required this.userPic,
      required this.userFar,
      required this.likeNum,
      required this.like});

  String kcal;
  List<int> data;
  String timeAdvice;
  bool link;
  String userName;
  String likeNum;
  bool like;
  String userPic;
  String userFar;

  factory SingleList.mock() => SingleList(
      kcal: '17.6Kcal',
      data: List.generate(30, (index) => Random().nextInt(101) + 500),
      timeAdvice: '时长感人',
      link: false,
      userName: '躲入棺材',
      likeNum: '12.6k',
      userPic: 'https://via.placeholder.com/150/0000F0/808080?Text=Image0',
      userFar:'16.2',
      like: false);
}

class DoubleList {
  DoubleList({
    required this.kcal,
    required this.data1,
    required this.data2,
    required this.timeAdvice,
    required this.link,
    required this.userName,
    required this.likeNum,
    required this.like,
    required this.userPic,
    required this.userFar,
  });

  String kcal;
  List<int> data1;
  List<int> data2;
  String timeAdvice;
  bool link;
  String userName;
  String likeNum;
  bool like;
  String userPic;
  String userFar;
  factory DoubleList.mock() => DoubleList(
      kcal: '17.6Kcal',
      data1: List.generate(30, (index) => Random().nextInt(1023)),
      data2: List.generate(30, (index) => Random().nextInt(101) + 500),
      timeAdvice: '时长感人',
      link: false,
      userName: '躲入棺材',
      likeNum: '12.6k',
      userPic:'https://via.placeholder.com/150/0000F0/808080?Text=Image0',
      userFar: '16.2',
      like: false);

  Map<String, dynamic> toJson() => {
        "kcal": kcal,
        "data1": List<dynamic>.from(data1.map((x) => x)),
        "data2": List<dynamic>.from(data2.map((x) => x)),
        "timeAdvice": timeAdvice,
        "link": link,
        "userName": userName,
        "likeNum": likeNum,
      };
}

class SpecialList {
  SpecialList({
    required this.kcal,
    required this.data,
    required this.timeAdvice,
    required this.link,
    required this.userName,
    required this.likeNum,
    required this.like,
    required this.userFar,
    required this.userPic,
  });

  String kcal;
  List<int> data;
  String timeAdvice;
  bool link;
  String userName;
  String likeNum;
  bool like;
  String userPic;
  String userFar;
  factory SpecialList.mock() => SpecialList(
      kcal: '17.6Kcal',
      data: List.generate(30, (index) => Random().nextInt(101) + 500),
      timeAdvice: '时长感人',
      link: false,
      userName: '躲入棺材',
      likeNum: '12.6k',
      userPic:'https://via.placeholder.com/150/0000F0/808080?Text=Image0',
      userFar: '16.2',
      like: false);

  Map<String, dynamic> toJson() => {
        "kcal": kcal,
        "data": List<dynamic>.from(data.map((x) => x)),
        "timeAdvice": timeAdvice,
        "link": link,
        "userName": userName,
        "likeNum": likeNum,
      };
}
