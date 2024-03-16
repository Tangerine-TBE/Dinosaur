// import 'dart:async';
// import 'package:app_base/ble/ble_msg.dart';
// import 'package:app_base/mvvm/base_ble_controller.dart';
// import 'package:app_base/exports.dart';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:get/get.dart';
//
// class TestController extends BaseBleController {
//   final String _deviceName = 'XHT';
//   bool queenSend = false;
//
//   var _isLooping = false;
//   var _processValue = 0;
//   final List<int> _mCustomHeader = [0x03, 0x12, 0xf3];
//   final List<int> _mCustomSilentHeader = [0x03,0x12,0xf5];
//   final List<int> _mCustomModelPlayHeader = [0x03,0x12,0xF1];
//   final List<int> _mUnQueueHeader = [0x03, 0x12, 0xf0];
//   final List<int> _mModel = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12];
//   late CountDownController countDownController;
//   final absorb = true.obs;
//   var _processCountDownValue = 0.0;
//   var processCountDownValue = 0.0.obs;
//
//   @override
//   void onAdapterStateChanged(BluetoothAdapterState state) {
//     if (state == BluetoothAdapterState.off) {
//       showToast('蓝牙已关闭!请打开蓝牙');
//     } else {
//       startScan(timeout: 15);
//     }
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     countDownController = CountDownController();
//   }
//
//   void addModel() {
//     //添加一个模版
//     //当点击这个按钮时
//     //判断当前sliver是否被onPress 没有则给个提示
//     //如果有则不断的写入当前强度值
//     _recordList.clear();
//     countDownController.restart(duration: 10);
//     countDownController.pause();
//     absorb.value = false;
//   }
//
//   void onCountDownProcessChanged(double value) {
//     _processCountDownValue = value;
//   }
//
//   final List<double> _recordList = <double>[];
//   bool _isOnDown = false;
//
//   void onSliverDown() async {
//     _isOnDown = true;
//     countDownController.resume();
//     while (_isOnDown) {
//       write(generateStrengthSilentData( streamFirstValue: _processCountDownValue.toInt(), streamSecondValue: _processCountDownValue.toInt()));
//       await Future.delayed(const Duration(milliseconds: 200));
//     }
//   }
//
//   void onSliverUp() {
//     _isOnDown = false;
//     countDownController.pause();
//     if (absorb.value) {
//       processCountDownValue.value = 0.0;
//     }
//   }
//
//   void onCountChange(String value) {
//     if (value == 10.toString()) {
//       _isOnDown = false;
//       onCountDownComplete();
//     }
//   }
//
//   void onCountDownComplete() async {
//     //完成录制
//     logE(_recordList.length.toString());
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       absorb.value = true;
//     });
//   }
//
//   void playModel() {
//     //播放一个模版
//     write(generateAutoPlay());
//   }
//
//
//   @override
//   void onScanResultChanged(List<ScanResult> resultList) async {
//     //查询结果
//     for (var element in resultList) {
//       var resultDevice = element.device;
//       if (resultDevice.platformName.startsWith(_deviceName)) {
//         stopScan();
//         await Future.delayed(Duration(seconds: 2));
//         connect(resultDevice, 20);
//         break;
//       }
//     }
//   }
//
//   @override
//   void onScanStateChanged(bool state) {}
//
//   @override
//   void onDeviceConnected(BluetoothDevice? device) async {
//     //当连接达成后
//     if (device != null && device.isConnected == true) {
//       logE('达成连接');
//       List<BluetoothService> services = await device.discoverServices();
//       services.forEach((service) async {
//         var characteristics = service.characteristics;
//         for (BluetoothCharacteristic c in characteristics) {
//           if (c.characteristicUuid == Guid.fromString(BleMSg.writeUUID)) {
//             setWriteChar(c);
//           }
//         }
//       });
//     }
//   }
//
//   @override
//   void onDeviceDisconnected() async {
//     await Future.delayed(const Duration(seconds: 2));
//     startScan(timeout: 20);
//   }
//
//   @override
//   void onDeviceUnKnowError(BluetoothConnectionState state) {}
//
//   void buttonClicked(int model) {
//     if (getDeviceStatus() == true) {
//       write(generateModelData(model));
//     }
//   }
//   List<int> generateAutoPlay(){
//     //streamFirst表示通道一设置
//     List<int> streamFirst = List.generate(8, (index) => 00);
//     //streamSecond表示通道二设置
//     List<int> streamSecond = List.generate(8, (index) => 00);
//     streamFirst[0] = 0xff;
//     streamFirst[1] = 0xff;
//     streamFirst[2] = 0xff;
//     streamFirst[3] = 0xff;
//     streamFirst[4] = 0xff;
//     streamFirst[5] = 0xff;
//     streamFirst[6] = 0xff;
//     streamFirst[7] = 0xff;
//     streamSecond[0] = 0x00;
//     streamSecond[1] = 0x00;
//     streamSecond[2] = 0x00;
//     streamSecond[3] = 0x00;
//     streamSecond[4] = 0x00;
//     streamSecond[5] = 0x00;
//     streamSecond[6] = 0x00;
//     streamSecond[7] = 0x00;
//     List<int> data = initData();
//     data.replaceRange(0, 8, streamFirst);
//     data.replaceRange(8, 17, streamSecond);
//     var cmdData = <int>[];
//     cmdData.addAll(_mCustomModelPlayHeader);
//     cmdData.addAll(data);
//     cmdData.add(0);
//     return cmdData;
//   }
//   List<int> generateStrengthData({
//     int streamFirstValue = 0,
//     int streamSecondValue = 0,
//     int streamFirstHz = 0,
//     int streamFirstTime = 0,
//     int streamSecondHz = 0,
//     int streamSecondTime = 0,
//     int streamFirstKeepTime = 50,
//     int streamSecondKeepTime = 50,
//   }) {
//     //streamFirst表示通道一设置
//     List<int> streamFirst = List.generate(8, (index) => 00);
//     //streamSecond表示通道二设置
//     List<int> streamSecond = List.generate(8, (index) => 00);
//     //streamFirst配置设置 --频率单位设置
//     //streamFirst强度值设置
//     int streamFirstResult = 0;
//     int streamSecondResult = 0;
//     if (streamFirstValue != 0) {
//       streamFirstResult = streamFirstValue << 6 | streamFirstKeepTime;
//       List<int> streamFirstResults = streamFirstResult.toBytes();
//       streamFirstResults.removeWhere((element) => element == 00);
//       if (streamFirstResults.length == 1) {
//         streamFirstResults.add(0);
//       }
//       streamFirst.replaceRange(6, 8, streamFirstResults);
//     }
//     if (streamSecondValue != 0) {
//       streamSecondResult = streamSecondValue << 6 | streamSecondKeepTime;
//       List<int> streamSecondResults = streamSecondResult.toBytes();
//       streamSecondResults.removeWhere((element) => element == 00);
//       if (streamSecondResults.length == 1) {
//         streamSecondResults.add(0);
//       }
//       streamSecond.replaceRange(6, 8, streamSecondResults);
//     }
//     List<int> data = initData();
//     data.replaceRange(0, 8, streamFirst);
//     data.replaceRange(8, 17, streamSecond);
//     var cmdData = <int>[];
//     cmdData.addAll(_mCustomHeader);
//     cmdData.addAll(data);
//     cmdData.add(0);
//     return cmdData;
//   }
//
//   List<int> generateStrengthSilentData({
//     int streamFirstValue = 0,
//     int streamSecondValue = 0,
//     int streamFirstHz = 0,
//     int streamFirstTime = 0,
//     int streamSecondHz = 0,
//     int streamSecondTime = 0,
//     int streamFirstKeepTime = 50,
//     int streamSecondKeepTime = 50,
// }){
//     //streamFirst表示通道一设置
//     List<int> streamFirst = List.generate(8, (index) => 00);
//     //streamSecond表示通道二设置
//     List<int> streamSecond = List.generate(8, (index) => 00);
//     //streamFirst配置设置 --频率单位设置
//     //streamFirst强度值设置
//     int streamFirstResult = 0;
//     int streamSecondResult = 0;
//     if (streamFirstValue != 0) {
//       streamFirstResult = streamFirstValue << 6 | streamFirstKeepTime;
//       List<int> streamFirstResults = streamFirstResult.toBytes();
//       streamFirstResults.removeWhere((element) => element == 00);
//       if (streamFirstResults.length == 1) {
//         streamFirstResults.add(0);
//       }
//       streamFirst.replaceRange(6, 8, streamFirstResults);
//     }
//     if (streamSecondValue != 0) {
//       streamSecondResult = streamSecondValue << 6 | streamSecondKeepTime;
//       List<int> streamSecondResults = streamSecondResult.toBytes();
//       streamSecondResults.removeWhere((element) => element == 00);
//       if (streamSecondResults.length == 1) {
//         streamSecondResults.add(0);
//       }
//       streamSecond.replaceRange(6, 8, streamSecondResults);
//     }
//     List<int> data = initData();
//     data.replaceRange(0, 8, streamFirst);
//     data.replaceRange(8, 17, streamSecond);
//     var cmdData = <int>[];
//     cmdData.addAll(_mCustomSilentHeader);
//     cmdData.addAll(data);
//     cmdData.add(0);
//     return cmdData;
// }
//
//   List<int> unQueue() {
//     List<int> data = initData();
//     data[0] = 0x07;
//     var cmdData = <int>[];
//     cmdData.addAll(_mUnQueueHeader);
//     cmdData.addAll(data);
//     return cmdData;
//   }
//
//   List<int> initData() {
//     return List.generate(17, (index) => 00);
//   }
//
//   processWrite(double v) async {
//     //1.开始滑动，触发循环机制
//     _processValue = v.toInt();
//     if (!_isLooping) {
//       _isLooping = true;
//       loopAndSend();
//     }
//   }
//
//   Future<void> loopAndSend() async {
//     do {
//       write(generateStrengthData(
//           streamFirstValue: _processValue, streamSecondValue: _processValue));
//       await Future.delayed(const Duration(milliseconds: 200));
//     } while (_processValue > 50);
//     _isLooping = false;
//     int i = 5;
//     while (i >= 0) {
//       write(generateModelData(0));
//       i--;
//     }
//   }
//
//   List<int> generateModelData(int i) {
//     List<int> data = initData();
//     data.replaceRange(0, 2, _mCustomHeader);
//     data[2] = _mModel[i];
//     return data;
//   }
// }
