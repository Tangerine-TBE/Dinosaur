
import 'package:dinosaur/app/src/moudle/test/device/play_device.dart';
import 'package:get/get.dart';
class Runtime{
  static String lastConnectDevice = '';
  static Rx<DeviceInfo?> deviceInfo = Rx(null);
  static checkRuntimeBleEnable(){
    if (deviceInfo.value == null) {
      return false;
    }
    if (deviceInfo.value!.bluetoothDevice.isDisconnected) {
      return false;
    }
    return true;
  }
}