import 'package:app_base/ble/ble_manager.dart';
import 'package:app_base/constant/constants.dart';
import 'package:app_base/constant/run_time.dart';
import 'package:app_base/exports.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class ScanController extends BaseController implements BlueToothInterface {
  final devicesListId = 1;
  List<ScanResult> devices = [];
  final devicesSize = 0.obs;
  final bluetoothState = '蓝牙状态: 未开启'.obs;
  late BleManager manager;

  @override
  void onInit() async {
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

  @override
  void onClose() {
    super.onClose();
    manager.stopScan();
  }

  @override
  void onAdapterStateChanged(BluetoothAdapterState state) {
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

  onDeviceSelected(int index) async {
    var resultDevice = devices[index];
    manager.stopScan();
    manager.connect(resultDevice.device, 20);
  }

  @override
  void onDeviceConnected(BluetoothDevice? device) {
    Get.back();
  }

  @override
  void onDeviceDisconnected() async {
    await Future.delayed(const Duration(seconds: 2));
    manager.startScan(timeout: 20);
  }

  @override
  void onDeviceUnKnowError(BluetoothConnectionState state) {}

  @override
  void onScanResultChanged(List<ScanResult> resultList) {
    for (var element in resultList) {
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
}
