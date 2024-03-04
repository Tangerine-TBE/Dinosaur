import 'package:app_base/ble/ble_tools.dart';
import 'package:app_base/exports.dart';

class TestController extends BaseController{
    @override
  void onInit() {
    super.onInit();
    BleTools().checkBleAvailable();


  }
}