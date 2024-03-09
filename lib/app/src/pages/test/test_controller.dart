import 'dart:async';
import 'package:app_base/ble/ble_msg.dart';
import 'package:app_base/mvvm/base_ble_controller.dart';
import 'package:app_base/exports.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class TestController extends BaseBleController {
  String deviceName = 'XHT';
  Timer? dataSendTimer;
  bool queenSend = false;
  late BluetoothDevice connectedDevice;
  List<int> mCustomHeader = [0x03, 0x12, 0xf3];
  List<int> mUnQueueHeader = [0x03, 0x12, 0xf0];
  List<int> mModel = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12];
  var lastTime = DateTime.now();

  @override
  void onAdapterStateChanged(BluetoothAdapterState state) {
    if (state == BluetoothAdapterState.off) {
      showToast('蓝牙已关闭!请打开蓝牙');
    } else {
      startScan(timeout: 15);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onScanResultChanged(List<ScanResult> resultList) async {
    //查询结果
    for (var element in resultList) {
      var resultDevice = element.device;
      if (resultDevice.platformName.startsWith(deviceName)) {
        stopScan();
        await Future.delayed(Duration(seconds: 2));
        connect(resultDevice, 20);
        break;
      }
    }
  }

  @override
  void onScanStateChanged(bool state) {}

  @override
  void onDeviceConnected(BluetoothDevice? device) async {
    //当连接达成后
    if (device != null && device.isConnected == true) {
      logE('达成连接');
      List<BluetoothService> services = await device.discoverServices();
      services.forEach((service) async {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.characteristicUuid == Guid.fromString(BleMSg.writeUUID)) {
            setWriteChar(c);
          }
        }
      });
    }
  }

  @override
  void onDeviceDisconnected() async {
    await Future.delayed(const Duration(seconds: 2));
    startScan(timeout: 20);
  }

  @override
  void onDeviceUnKnowError(BluetoothConnectionState state) {}

  void buttonClicked(int model) {
    if (getDeviceStatus() == true) {
      write(generateModelData(model));
    }
  }

  List<int> generateStrengthData({
    int streamFirstValue = 0,
    int streamSecondValue = 0,
    int streamFirstHz = 0,
    int streamFirstTime = 0,
    int streamSecondHz = 0,
    int streamSecondTime = 0,
    int streamFirstKeepTime = 50,
    int streamSecondKeepTime = 50,
  }) {
    //streamFirst表示通道一设置
    List<int> streamFirst = List.generate(8, (index) => 00);
    //streamSecond表示通道二设置
    List<int> streamSecond = List.generate(8, (index) => 00);
    //streamFirst配置设置 --频率单位设置
    //streamFirst强度值设置
    int streamFirstResult = 0;
    int streamSecondResult = 0;
    if (streamFirstValue != 0) {
      streamFirstResult = streamFirstValue << 6 | streamFirstKeepTime;
      List<int> streamFirstResults = streamFirstResult.toBytes();
      streamFirstResults.removeWhere((element) => element == 00);
      if (streamFirstResults.length == 1) {
        streamFirstResults.add(0);
      }
      streamFirst.replaceRange(6, 8, streamFirstResults);
    }
    if (streamSecondValue != 0) {
      streamSecondResult = streamSecondValue << 6 | streamSecondKeepTime;
      List<int> streamSecondResults = streamSecondResult.toBytes();
      streamSecondResults.removeWhere((element) => element == 00);
      if (streamSecondResults.length == 1) {
        streamSecondResults.add(0);
      }
      streamSecond.replaceRange(6, 8, streamSecondResults);
    }
    List<int> data = initData();
    data.replaceRange(0, 8, streamFirst);
    data.replaceRange(8, 17, streamSecond);
    var cmdData = <int>[];
    cmdData.addAll(mCustomHeader);
    cmdData.addAll(data);
    cmdData.add(0);
    return cmdData;
  }

  List<int> unQueue() {
    List<int> data = initData();
    data[0] = 0x07;
    var cmdData = <int>[];
    cmdData.addAll(mUnQueueHeader);
    cmdData.addAll(data);
    return cmdData;
  }

  List<int> initData() {
    return List.generate(17, (index) => 00);
  }

  var isLooping = false;
  var processValue = 0;

  processWrite(double v) async {
    //1.开始滑动，触发循环机制
    processValue = v.toInt();
    if (!isLooping) {
      isLooping = true;
      loopAndSend();
    }
  }

  Future<void> loopAndSend() async {
    do {
      write(generateStrengthData(
          streamFirstValue: processValue, streamSecondValue: processValue));
      await Future.delayed(const Duration(milliseconds: 200));
    } while (processValue > 50);
    isLooping = false;
    int i = 5;
    while(i >=0){
      write(generateModelData(0));
      i--;
    }
  }

  List<int> generateModelData(int i) {
    List<int> data = initData();
    data.replaceRange(0, 2, mCustomHeader);
    data[2] = mModel[i];
    return data;
  }
}
