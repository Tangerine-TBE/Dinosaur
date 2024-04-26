import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceInfo {
  bool isCanAddHot = false;
  bool isCanSubControl = false;
  int classModelCount = 12;
  String name;
  BluetoothDevice bluetoothDevice;
  BluetoothCharacteristic writeChar;
  String  type ;
  DeviceInfo({
    required this.type,
    required this.isCanAddHot,
    required this.isCanSubControl,
    required this.classModelCount,
    required this.bluetoothDevice,
    required this.name,
    required this.writeChar,
  });

}
