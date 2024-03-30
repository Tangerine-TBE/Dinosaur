class RecommonRsp {
  RecommonRsp({
    required this.recommon,
  });

  List<Recommon> recommon;

  factory RecommonRsp.fromJson(Map<dynamic, dynamic> json) => RecommonRsp(
        recommon: List<Recommon>.from(
            json["recommon"].map((x) => Recommon.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "recommon": List<dynamic>.from(recommon.map((x) => x.toJson())),
      };

  factory RecommonRsp.mock() => RecommonRsp(
        recommon: List.generate(
          10,
          (index) => Recommon.mock(),
        ),
      );
}

class Recommon {
  Recommon({
    required this.viewNum,
    required this.avatar,
    required this.id,
    required this.userName,
    required this.content,
    required this.title,
    required this.likeNUm,
  });

  String viewNum;
  String avatar;
  String id;
  String userName;
  String content;
  String title;
  String likeNUm;

  factory Recommon.fromJson(Map<dynamic, dynamic> json) => Recommon(
        viewNum: json["viewNum"],
        avatar: json["avatar"],
        id: json["id"],
        userName: json["userName"],
        content: json["content"],
        title: json["#Title"],
        likeNUm: json["likeNUm"],
      );

  factory Recommon.mock() => Recommon(
      viewNum: '1000',
      avatar: 'https://via.placeholder.com/150/0000F0/808080?Text=Image0',
      id: '01',
      userName: '无敌赛亚人',
      content: '你好呀',
      title: '春天来啦！',
      likeNUm: '1023');

  Map<dynamic, dynamic> toJson() => {
        "viewNum": viewNum,
        "avatar": avatar,
        "id": id,
        "userName": userName,
        "content": content,
        "#Title": title,
        "likeNUm": likeNUm,
      };
}
