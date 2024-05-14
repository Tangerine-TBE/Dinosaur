import 'dart:convert';

class SaveSettingReq {
  SaveSettingReq({
    required this.settings,
    required this.userId,
  });

  List<Setting> settings;
  String userId;

  factory SaveSettingReq.fromJson(Map<dynamic, dynamic> json) => SaveSettingReq(
    settings: List<Setting>.from(json["settings"].map((x) => Setting.fromJson(x))),
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "settings": List<dynamic>.from(settings.map((x) => x.toJson())),
    "userId": userId,
  };
}

class GetSettingRsp {
  GetSettingRsp({
    required this.settings,
  });

  List<Setting> settings;

  factory GetSettingRsp.fromJson(Map<dynamic, dynamic> json) => GetSettingRsp(
    settings: List<Setting>.from(json["settings"].map((x) => Setting.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "settings": List<dynamic>.from(settings.map((x) => x.toJson())),
  };
}

class Setting {
  Setting({
    required this.value,
    required this.key,
  });

  String value;
  String key;

  factory Setting.fromJson(Map<dynamic, dynamic> json) => Setting(
    value: json["value"],
    key: json["key"],
  );

  Map<dynamic, dynamic> toJson() => {
    "value": value,
    "key": key,
  };
}

