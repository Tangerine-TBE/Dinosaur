import 'dart:async';
import 'dart:io';
import 'package:app_base/ble/ble_msg.dart';
import 'package:app_base/mvvm/base_ble_controller.dart';
import 'package:app_base/exports.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class TestController extends BaseBleController {
  String deviceName = 'XHTKJ';
  Timer? dataSendTimer;
  bool queenSend = false;
  late BluetoothDevice connectedDevice;
  late List<int> mData;
  List<int> mCustomHeader = [0x03, 0x12, 0xf3];
  List<int> mClearHeader = [0x03, 0x12, 0xf0];
  List<int> mModel = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12];
  var lastTime = DateTime.now();

  @override
  void onAdapterStateChanged(BluetoothAdapterState state) {
    if (state == BluetoothAdapterState.off) {
      showToast('蓝牙已关闭!请打开蓝牙');
    }else{
      startScan(timeout: 15);
    }
  }

  @override
  void onInit() {
    mData = initData();
    super.onInit();
  }

  @override
  void onScanResultChanged(List<ScanResult> resultList)async {
    //查询结果
    for (var element in resultList) {
      var resultDevice = element.device;
      if (resultDevice.platformName == deviceName) {
        stopScan();
        await Future.delayed(Duration(seconds: 2));
        connect(resultDevice, 20);
        break;
      }
    }
  }

  @override
  void onScanStateChanged(bool state) {
    // if (!state) {
    //   if(!getDeviceStatus()){
    //     startScan(timeout: 15);
    //   }
    // }
  }
  @override
  void onDeviceConnected(BluetoothDevice? device) async {
    //当连接达成后
    if(  device != null && device.isConnected == true) {
      logE('达成连接');
      List<BluetoothService> services =

      await device.discoverServices();
      services.forEach((service) async {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.characteristicUuid == Guid.fromString(BleMSg.writeUUID)) {
            setWriteChar(c) ;
          }
        }
      });
    }

  }

  @override
  void onDeviceDisconnected() async {
    //当设备断开连接后
    await Future.delayed(Duration(seconds: 2));
    startScan(timeout: 20);
  }

  @override
  void onDeviceUnKnowError(BluetoothConnectionState state) {
  }


  void buttonClicked(int model) {
    if (getDeviceStatus() == true) {
        write(generateModelData(model));
    }
  }

  List<int> generateModelData(int i) {
    mData.replaceRange(0, 2, mCustomHeader);
    mData[2] = mModel[i];
    return mData;
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
    if (streamFirstValue != 0) {
      int streamFirstResult = streamFirstValue << 6 | streamFirstKeepTime;
      List<int> streamFirstResults = streamFirstResult.toBytes();
      streamFirstResults.removeWhere((element) => element == 00);
      streamFirst.replaceRange(6, 8, streamFirstResults);
      logE('通道一的数据为 ==$streamFirst ');
    }
    if(streamSecondValue != 0){
      int streamSecondResult = streamSecondValue << 6 | streamSecondKeepTime;
      List<int> streamSecondResults = streamSecondResult.toBytes();
      streamSecondResults.removeWhere((element) => element == 00);
      streamSecond.replaceRange(6, 8, streamSecondResults);
      logE('通道二的数据为 ==$streamSecond ');
    }
    mData = initData();
    mData.replaceRange(0, 8, streamFirst);
    mData.replaceRange(8, 17, streamSecond);
    var cmdData = <int>[];
    cmdData.addAll(mCustomHeader);
    cmdData.addAll(mData);
    cmdData.add(0);
    logE('发送的数据为 ==$cmdData ===size ==${cmdData.length}');
    return cmdData;
  }

  List<int> clear() {
    mData = initData();
    mData[0] = 0x03;
    var cmdData = <int>[];
    cmdData.addAll(mClearHeader);
    cmdData.addAll(mData);
    logE('发送的数据为 ==$cmdData ===size ==${cmdData.length}');
    return cmdData;
  }

  List<int> noQueen() {
    mData = initData();
    mData[0] = 0x07;
    var cmdData = <int>[];
    cmdData.addAll(mClearHeader);
    cmdData.addAll(mData);
    logE('发送的数据为 ==$cmdData ===size ==${cmdData.length}');
    return cmdData;
  }

  List<int> initData() {
    return List.generate(17, (index) => 00);
  }


  /// 1.process值 - n Int
  /// 2.每200ms select一次Sliver的值 并且发送
  /// 3.如果 - n Int >0 开始 200ms的循环
  /// 4.如果 - n Int <=0 停止 200ms的循坏
  var processValue = 0;
   processWrite(int v)  {
    //1.开始滑动，触发循环机制
    processValue = v;
    do{
      int value = (1023 / 100 * v).toInt();
      write(generateStrengthData(
          streamFirstValue: value, streamSecondValue: value));
      sleep(Duration(milliseconds: 200));
    }while(processValue > 0);

    //
    // var timer = Timer(Duration(milliseconds: 200),(){
    //
    // });
    //
    // var currentTime = DateTime.now();
    // if (currentTime.millisecondsSinceEpoch - lastTime.millisecondsSinceEpoch >=
    //     500) {
    //   lastTime = currentTime;
    //
    // }
  }
  void finishWrite(int v){
    int value = (1023 / 100 * v).toInt();
    write(generateStrengthData(
        streamFirstValue: value, streamSecondValue: value));
  }


}
