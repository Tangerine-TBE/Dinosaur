import 'dart:async';

import 'package:app_base/exports.dart';
import 'package:common/base/mvvm/vm/base_view_model.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:event_bus/event_bus.dart';

import 'ble_manager.dart';
/// 这是为蓝牙定制的控制器 在binding的使用的时候必须是Get.put 不能采用lazy模式

abstract class BaseBleController extends BaseViewModel  {
  late BleManager manager;
  void onAdapterStateChanged(BluetoothAdapterState state);

  void onDeviceConnected(BluetoothDevice device);

  void onDeviceDisconnect();

  void onDeviceUnKnownError();

  void onScanResultChanged(List<ScanResult> result);

  @override
  void handleUnAuthorizedError(String? message) {}

  @override
  void onHidden() {}

  @override
  void showEmpty() {}

  @override
  void showError(String? message) {}

  @override
  void onInit() {
    super.onInit();
    manager = BleManager();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
