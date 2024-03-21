/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation
library;

import 'dart:convert';

BleDevice bleDeviceFromJson(String str) => BleDevice.fromJson(json.decode(str));

String bleDeviceToJson(BleDevice data) => json.encode(data.toJson());

class BleDevice {
    BleDevice({
        required this.deviceName,
        required this.deviceNotify,
        required this.deviceWrite,
    });

    String deviceName;
    String deviceNotify;
    String deviceWrite;

    factory BleDevice.fromJson(Map<dynamic, dynamic> json) => BleDevice(
        deviceName: json["deviceName"],
        deviceNotify: json["deviceNotify"],
        deviceWrite: json["deviceWrite"],
    );

    Map<dynamic, dynamic> toJson() => {
        "deviceName": deviceName,
        "deviceNotify": deviceNotify,
        "deviceWrite": deviceWrite,
    };
}
