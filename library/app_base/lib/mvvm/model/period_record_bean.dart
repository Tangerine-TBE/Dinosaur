class SavePeriodRecordReq {
  SavePeriodRecordReq({
    required this.deletes,
    required this.creates,
    required this.userId,
  });

  List<DateTime> deletes;
  List<DateTime> creates;
  String userId;

  factory SavePeriodRecordReq.fromJson(Map<dynamic, dynamic> json) =>
      SavePeriodRecordReq(
        deletes:
            List<DateTime>.from(json["deletes"].map((x) => DateTime.parse(x))),
        creates:
            List<DateTime>.from(json["creates"].map((x) => DateTime.parse(x))),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "deletes": List<dynamic>.from(deletes.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "creates": List<dynamic>.from(creates.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "userId": userId,
      };
}

class GetPeriodRecordReq {
  List<DateTime> fromDate;
  List<DateTime> toDate;
  String userId;

  GetPeriodRecordReq({
    required this.fromDate,
    required this.toDate,
    required this.userId,
  });

  factory GetPeriodRecordReq.fromJson(Map<dynamic, dynamic> json) =>
      GetPeriodRecordReq(
        fromDate:
            List<DateTime>.from(json["deletes"].map((x) => DateTime.parse(x))),
        toDate:
            List<DateTime>.from(json["creates"].map((x) => DateTime.parse(x))),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "fromDate": List<dynamic>.from(fromDate.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "toDate": List<dynamic>.from(toDate.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "userId": userId,
      };
}

class GetPeriodRecordRsp {
  GetPeriodRecordRsp({
    required this.dateList,
  });

  List<DateTime> dateList;

  factory GetPeriodRecordRsp.fromJson(Map<dynamic, dynamic> json) =>
      GetPeriodRecordRsp(
        dateList: List<DateTime>.from(
          json["dateList"].map(
            (x) => DateTime.parse(x),
          ),
        ),
      );

  Map<dynamic, dynamic> toJson() => {
        "dateList": List<dynamic>.from(
          dateList.map((x) =>
              "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}"),
        ),
      };
}
