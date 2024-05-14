class SavePeriodRecordReq {
  SavePeriodRecordReq({
    required this.endDate,
    required this.startDate,
    required this.userId,
  });

  DateTime startDate;
  DateTime endDate;
  String userId;

  Map<String, dynamic> toJson() => {
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "userId": userId,
      };
}

class GetPeriodRecordReq {
  DateTime fromDate;
  DateTime toDate;
  String userId;

  GetPeriodRecordReq({
    required this.fromDate,
    required this.toDate,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        "fromDate":
            "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "toDate":
            "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "userId": userId,
      };
}

class GetPeriodRecordRsp {
  GetPeriodRecordRsp({
    required this.dateList,
  });

  DateList dateList;

  factory GetPeriodRecordRsp.fromJson(Map<dynamic, dynamic> json) =>
      GetPeriodRecordRsp(
        dateList: DateList.fromJson(json["dateList"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "dateList": dateList.toJson(),
      };
}

class GetPeriodRecordRsp1 {
  DateTime startDate;
  DateTime endDate;

  GetPeriodRecordRsp1({required this.startDate, required this.endDate});

  factory GetPeriodRecordRsp1.fromJson(Map<dynamic, dynamic> json) =>
      GetPeriodRecordRsp1(
        startDate: DateTime.parse(json["startDate"] ?? '1990-10-01'),
        endDate: DateTime.parse(json["endDate"] ?? '1990-10-01'),
      );

}

class DateList {
  DateList({
    required this.endDate,
    required this.startDate,
  });

  DateTime endDate;
  DateTime startDate;

  factory DateList.fromJson(Map<dynamic, dynamic> json) => DateList(
        endDate: DateTime.parse(json["endDate"] ?? '1990-10-01'),
        startDate: DateTime.parse(json["startDate"] ?? '1990-10-01'),
      );

  Map<dynamic, dynamic> toJson() => {
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      };
}
