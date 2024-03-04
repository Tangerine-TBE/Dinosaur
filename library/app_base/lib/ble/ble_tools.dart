import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleTools {
  /// 蓝牙链接 一般为 1.检查蓝牙权限，是否打开蓝牙
  ///               2.扫描
  ///               3.链接
  ///               4.达成链接读取数据写入数据等
  void checkBleAvailable() async {
    if (await FlutterBluePlus.isSupported == false) {
      print("Not Supported");
      return;
    }
    // handle bluetooth on & off
    // note: for iOS the initial state is typically BluetoothAdapterState.unknown
    // note: if you have permissions issues you will get stuck at BluetoothAdapterState.unauthorized
    var subscription =
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      print(state);
      if (state == BluetoothAdapterState.on) {
        //start connect
      } else {
        //
      }
    });
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
    subscription.cancel();
  }

  void bleScanner() async{
    var subscription = FlutterBluePlus.onScanResults.listen(
      (result) {
        if (result.isNotEmpty) {
          ScanResult scanResult = result.last;
          print(
              '${scanResult.device.remoteId}: "${scanResult.advertisementData.advName}" found!');
        }
      },
      onError: (e) => print(e),
      onDone: () {},
    );
    FlutterBluePlus.cancelWhenScanComplete(subscription);
    await FlutterBluePlus.adapterState.where((val) => val == BluetoothAdapterState.on).first;
    await FlutterBluePlus.startScan(timeout: Duration(seconds: 15));
    await FlutterBluePlus.isScanning.where((val)=>val == false).first;
  }
}
