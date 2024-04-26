import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/device/play_device.dart';
import 'package:dinosaur/app/src/moudle/test/device/run_time.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'base_ble_controller.dart';
import 'ble_msg.dart';

///业务层面
class PlayDeviceBleController extends BaseBleController {
  @override
  void onAdapterStateChanged(BluetoothAdapterState state) {}

  @override
  void onDeviceDisconnect() async {
    Runtime.deviceInfo.value = null;
    await Future.delayed(const Duration(seconds: 2));
    if (Runtime.lastConnectDevice.isNotEmpty) {
      manager.startScan(timeout: 20);
    }
  }

  @override
  void onDeviceUnKnownError() {}

  @override
  void onScanResultChanged(List<ScanResult> result) async {
    for (var element in result) {
      var resultDevice = element.device;
      if (Runtime.lastConnectDevice.isNotEmpty &&
          resultDevice.remoteId.str.startsWith(Runtime.lastConnectDevice)) {
        manager.stopScan();
        await Future.delayed(
          const Duration(seconds: 2),
        );
        if(resultDevice.isDisconnected){
          manager.connect(resultDevice, 20);
        }
      }
    }
  }

  @override
  void onDeviceConnected(BluetoothDevice device) async {
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
          logE(this.toString());
          showToast('达成连接');
          break;
        }
      }
    }
  }

  checkDeviceType(int num) {
    if (num == 2) {
      return '030';
    } else if (num == 3) {
      return '035';
    } else if (num == 1) {
      return '018';
    } else if (num == 4) {
      return '019';
    } else if (num == 29) {
      return '029';
    } else if (num == 71) {
      return '071';
    }else {
      return '000';
    }
  }

  bool isCanAddHot() {
    return false;
  }
}
