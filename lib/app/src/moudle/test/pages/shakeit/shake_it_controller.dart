import 'dart:math';

import 'package:app_base/ble/ble_msg.dart';
import 'package:app_base/constant/run_time.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_ble_controller.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:get/get.dart';
import 'dart:async';

class ShakeItController extends BaseBleController {
  final threshold = 0.0.obs;
  final vector = 15;
  final bleMsg = BleMSg();
  final _processes = List.generate(10, (index) => 0.0);
  Timer? looperTimer;
  late StreamSubscription<UserAccelerometerEvent> steam;

  @override
  void onInit() {
    super.onInit();
    steam = userAccelerometerEventStream().listen (
      (UserAccelerometerEvent event) async {
        // logD(
        //     'x:${event.x.toInt()}   y:${event.y.toInt()}   z:${event.z.toInt()}');
        //1.这里通过判断同一间的xyz的绝对值中的最大值取震动基数
        var x = event.x.round().abs();
        var y = event.y.round().abs();
        var z = event.z.round().abs();
        //晃动的最大值为20
        var thresholdSeed = min(max(max(x, y), z), vector);
        //50-1023 为蓝牙数值  //低于50判定为不震动
        //(1023-0) /100 * threshold 为需要震动的数值
        threshold.value = thresholdSeed.toDouble();
      },
      onError: (error) {},
      cancelOnError: true,
    );
  }

  onShakeIt(double value) {
    add(value);
    looperTimer ??= Timer.periodic(const Duration(milliseconds: 600), (timer) async{
      logE('${_processes[0]}');
      var belValue = 1023 / vector * _processes[0];
      manager.wwriteChar?.write(bleMsg.generateStrengthData(
          streamFirstValue: belValue.toInt(),
          streamSecondValue: belValue.toInt()));
    },);
  }

  @override
  void onClose() {
    looperTimer?.cancel();
    steam.cancel();
    super.onClose();
  }

  @override
  void onAdapterStateChanged(BluetoothAdapterState state) {}

  @override
  void onDeviceConnected(BluetoothDevice device) async {
    dismiss();
    if (device.isConnected == true) {
      showToast('达成连接');
      List<BluetoothService> services = await device.discoverServices();
      services.forEach((service) {
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
  void onDeviceDisconnect() async {
    await Future.delayed(const Duration(seconds: 2));
    if (Runtime.lastConnectDevice.isNotEmpty) {
      manager.startScan(timeout: 20);
    }
  }

  @override
  void onDeviceUnKnownError() {}

  @override
  void onScanResultChanged(List<ScanResult> result) async {
    logE('扫描有结果了');
    for (var element in result) {
      var resultDevice = element.device;
      if (resultDevice.platformName.startsWith(Runtime.lastConnectDevice)) {
        manager.stopScan();
        await Future.delayed(
          const Duration(seconds: 2),
        );
        manager.connect(resultDevice, 20);
      }
    }
  }

  void add(double data) {
    for (int i = _processes.length - 1; i > 0; i--) {
      _processes[i] = _processes[i - 1];
    }
    _processes[0] = data;
  }
}
