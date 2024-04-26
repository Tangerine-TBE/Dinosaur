import 'dart:async';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/device/play_deivce_ble_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:app_base/constant/constants.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../device/ble_msg.dart';
import '../../device/play_device.dart';
import '../../device/run_time.dart';

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
      if(!FlutterBluePlus.isScanningNow){
        manager.startScan(timeout: 20);
      }
    }
  }
  @override
  void onDeviceDisconnect() async {
    devices.clear();
    Runtime.deviceInfo.value = null;
    devicesSize.value = devices.length;
    update([devicesListId]);
    await Future.delayed(const Duration(seconds: 2));
    dismiss();
    manager.startScan(timeout: 20);
  }
  @override
  void onDeviceConnected(BluetoothDevice device) async{
    if (device.isConnected) {
      List<BluetoothService> services = await device.discoverServices();
      String type = '';
      BluetoothCharacteristic? writeChar;
      for(var service in services) {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.characteristicUuid == Guid.fromString(BleMSg.writeUUID)) {
            writeChar = c;
          }
          if (c.characteristicUuid == Guid.fromString(BleMSg.deviceInfoUUID)) {
            List<int> deviceInfo = await c.read();
            logE(deviceInfo.toString());
            if (deviceInfo.isNotEmpty) {
              type = checkDeviceType(deviceInfo[3]);
            }
          }
        }
        if (writeChar != null && type != '') {
          bool isCanAddHot = (type == '018' ||
              type == '030' ||
              type == '029' ||
              type == '071');
          bool isCanSubControl = (type == '035' || type == '019');
          int classicModelCount = type == '019'
              ? 9
              : type == '030'
              ? 10
              : isCanSubControl
              ? 10
              : 12;
          DeviceInfo deviceInfo = DeviceInfo(
              type: type,
              isCanAddHot: isCanAddHot,
              isCanSubControl: isCanSubControl,
              classModelCount: classicModelCount,
              bluetoothDevice: device,
              name: device.platformName,
              writeChar: writeChar);
          Runtime.deviceInfo.value = deviceInfo;
          Runtime.lastConnectDevice = device.remoteId.str;
          showToast('达成连接');
          break;
        }
      }
    }
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
          if(!element.device.isConnected){
            devices.add(element);
            update([devicesListId]);
            devicesSize.value = devices.length;
          }
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    manager.startScan(timeout: 20);
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
