import 'dart:async';
import 'package:app_base/ble/ble_msg.dart';
import 'package:dinosaur/app/src/moudle/test/device/play_deivce_ble_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:app_base/ble/event/ble_event.dart';
import 'package:app_base/constant/constants.dart';
import 'package:app_base/mvvm/base_ble_controller.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class ScanController extends PlayDeviceBleController {
  final devicesListId = 1;
  List<ScanResult> devices = [];
  final devicesSize = 0.obs;
  final bluetoothState = '蓝牙状态: 未开启'.obs;

  @override
  onAdapterStateChanged(BluetoothAdapterState state) {
    if (state == BluetoothAdapterState.off) {
      bluetoothState.value = '蓝牙状态: 未开启';
      devicesSize.value = 0;
      devices.clear();
      update([devicesListId]);
    } else {
      bluetoothState.value = '蓝牙状态: 已开启';
      manager.startScan(timeout: 20);
    }
  }
  @override
  void onDeviceDisconnect() async {
    devices.clear();
    devicesSize.value = devices.length;
    update([devicesListId]);
    await Future.delayed(const Duration(seconds: 2));
    dismiss();
    manager.startScan(timeout: 20);
  }
  @override
  void onDeviceConnected(BluetoothDevice device) {
    super.onDeviceConnected(device);
    EasyLoading.showSuccess('连接成功!');
    Get.back();
  }

  @override
  void onScanResultChanged(List<ScanResult> result) {
    for (var element in result) {
      var resultDevice = element.device;
      if (resultDevice.platformName.startsWith(Constants.bleSearchName)) {
        bool shouldAdd = true;
        for (var i in devices) {
          if (resultDevice.platformName == i.device.platformName) {
            shouldAdd = false;
          }
          if (resultDevice.advName == i.device.advName) {
            shouldAdd = false;
          }
          if (resultDevice.remoteId == i.device.remoteId) {
            shouldAdd = false;
          }
        }
        if (shouldAdd) {
          devices.add(element);
          update([devicesListId]);
          devicesSize.value = devices.length;
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    eventBus.fire(AdapterStateChangedEvent(BluetoothAdapterState.on));
  }

  @override
  void onClose() {
    manager.stopScan();
    super.onClose();
  }

  onDeviceSelected(int index) async {
    var resultDevice = devices[index];
    showLoading(userInteraction: false);
    manager.stopScan();
    await Future.delayed(const Duration(seconds: 2));
    manager.connect(resultDevice.device, 10);
  }
}
