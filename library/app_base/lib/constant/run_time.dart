import 'package:app_base/ble/ble_manager.dart';

class Runtime{
  static BleManager? bleManager;

  static checkRuntimeBleEnable(){
    if(bleManager == null ){
      return false;
    }
    if(bleManager!.mDevice.value == null){
      return false;
    }
    if(bleManager!.wwriteChar == null){
      return false;
    }
    return true;
  }

}