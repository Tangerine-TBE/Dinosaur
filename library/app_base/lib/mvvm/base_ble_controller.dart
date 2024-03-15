import 'dart:async';
import 'package:app_base/exports.dart';
import 'package:common/base/mvvm/vm/base_view_model.dart';
import 'package:common/common/network/status_code.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../ble/ble_manager.dart';
import '../ble/ble_msg.dart';
import '../constant/constants.dart';
import '../constant/run_time.dart';

/** 这是为蓝牙定制的控制器 在binding的使用的时候必须是Get.put 不能采用lazy模式*/

abstract class BaseBleController extends BaseViewModel implements BlueToothInterface{
  @override
  void handleUnAuthorizedError(String? message) {
  }

  @override
  void onHidden() {
  }

  @override
  void showEmpty() {
  }

  @override
  void showError(String? message) {
  }
  late BleManager manager;
    @override
  void onInit() {
    super.onInit();
    var runTimeManager = Runtime.bleManager;
    if (runTimeManager == null) {
      manager = BleManager.create(this);
      Runtime.bleManager = manager;
    } else {
      manager = Runtime.bleManager!;
      manager.setInterface(this);
      onAdapterStateChanged(BluetoothAdapterState.on);
    }
  }
  /*5个接口必须有一个默认实现*/
  /*默认实现，在ScanController会被顶替掉*/
  /*其他与蓝牙相关的页面也必须继承这个类，用于断开后的自动重连*/
  @override
  void onDeviceConnected(BluetoothDevice? device) async {
    dismiss();
    if (device != null && device.isConnected == true) {
      logE('达成连接');
      List<BluetoothService> services = await device.discoverServices();
      services.forEach((service) async {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.characteristicUuid == Guid.fromString(BleMSg.writeUUID)) {
            manager.setWriteChar(c);
          }
        }
      });
    }
  }
  @override
  void onDeviceDisconnected() async {
    await Future.delayed(const Duration(seconds: 2));
    manager.startScan(timeout: 20);
  }
  @override
  onAdapterStateChanged(BluetoothAdapterState state) {
  }
  @override
  onDeviceUnKnowError(BluetoothConnectionState state) {
  }
  @override
  onScanResultChanged(List<ScanResult> resultList) {
    for (var element in resultList) {
      var resultDevice = element.device;
      if (resultDevice.platformName.startsWith(Constants.bleSearchName)) {

      }
    }
  }
}


