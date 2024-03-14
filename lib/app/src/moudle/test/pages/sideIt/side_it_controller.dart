import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:app_base/ble/ble_msg.dart';
import 'package:app_base/constant/run_time.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:app_base/exports.dart';
import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/obxBean/double_bean.dart';

class SideItController extends BaseController {
  final sliderValue = 0.obs;
  final Rx<DoubleBean> process = Rx(DoubleBean.create(obx: 0.0));
  final bleMsg = BleMSg();
  bool loopSending = true;
  BluetoothCharacteristic? wwriteChar;
  final customPaintId = 1;
  Timer? timer;

  Future<ui.Image> loadImage(String imagePath) async {
    ByteData data = await rootBundle.load(imagePath);
    Uint8List bytes = data.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  @override
  void onInit() async {
    super.onInit();
    wwriteChar = Runtime.bleManager?.wwriteChar;
    _initTimer();
  }

  _initTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      wwriteChar?.write(bleMsg.generateStrengthData(
          streamFirstValue: sliderValue.value,
          streamSecondValue: sliderValue.value));
      process.value = DoubleBean.create(obx: sliderValue.value.toDouble());
    });
  }

  _releaseTimer() {
    timer?.cancel();
    int i = 5;
    while (i >= 0) {
      wwriteChar?.write(
        bleMsg.generateModelData(0),
      );
      i--;
    }
  }

  @override
  onClose() {
    _releaseTimer();
    super.onClose();
  }

  onSliverProcessChanged(double process) {
    sliderValue.value = process.toInt();
  }

  onSliverDown() {
    logE('onSliverDown');
  }

  onSliverUp() {
    logE('onSliverUp');
  }
  onClassicClick(){
    if(Runtime.bleManager == null
     || Runtime.bleManager?.mDevice.value == null
     || Runtime.bleManager?.wwriteChar == null
      || Runtime.bleManager?.mDevice.value?.isConnected == false){
      navigateTo(RouteName.scanPage);
    }else{
      navigateTo(RouteName.modelPage);
    }
  }
}
