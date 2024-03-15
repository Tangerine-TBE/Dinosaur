import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:app_base/ble/ble_msg.dart';
import 'package:app_base/constant/run_time.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:app_base/exports.dart';
import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/obxBean/double_bean.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/widget/count_down_confirm_dialog.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/widget/create_custom_model_dialog.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/widget/timer_controller.dart';

class SideItController extends BaseController {
  final slideItModel = 0.obs;
  final sliderValue = 0.obs;
  final Rx<DoubleBean> process = Rx(DoubleBean.create(obx: 0.0));
  final bleMsg = BleMSg();
  bool loopSending = true;
  BluetoothCharacteristic? wwriteChar;
  final customPaintId = 1;
  Timer? loopTimer;
  Timer? recordTimer;
  late CountdownController countdownController;

  List<int> recordList = <int>[];

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
    countdownController = CountdownController();
    _initTimer();
  }

  _initTimer() {
    loopTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      wwriteChar?.write(bleMsg.generateStrengthData(
          streamFirstValue: sliderValue.value,
          streamSecondValue: sliderValue.value));
      process.value = DoubleBean.create(obx: sliderValue.value.toDouble());
    });
  }

  _releaseTimer() {
    recordTimer?.cancel();
    loopTimer?.cancel();
    int i = 5;
    while (i >= 0) {
      wwriteChar?.write(
        bleMsg.generateStopData(),
      );
      i--;
    }
  }

  onCountDownFinish() {
    slideItModel.value = 0;
    Get.dialog(
      CreateCustomModelDialog(
        onCancelCallBack: () {
          recordTimer?.cancel();
          sliderValue.value = 0;
        },
        onConfirmCallBack: (value) {
          //创建订单
          recordTimer?.cancel();
          sliderValue.value = 0;
          dynamic data = SaveKey.dataList.read;
          var dataList = DataList(recordList: recordList, recordName: value);
          RecordBean recordBean;
          if(data.runtimeType.toString() == 'Null'){
            recordBean = RecordBean(dataList: []);
          }else{
            recordBean = RecordBean.fromJson(data);
          }
          recordBean.dataList.add(dataList);
          SaveKey.dataList.save(recordBean.toJson());
        },
      ),
    );
  }

  @override
  onClose() {
    _releaseTimer();
    super.onClose();
  }

  onSliverProcessChanged(double process) {
    sliderValue.value = process.toInt();
  }

  onSliverDown() async  {
    if (slideItModel.value == 1) {
      countdownController.resume();
      recordTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
        recordList.add(sliderValue.value);
      });
    }
  }

  onSliverUp() {
    if (slideItModel.value == 1) {
      countdownController.pause();
      recordTimer?.cancel();
    }
  }

  onClassicClick() {
    if (Runtime.bleManager == null ||
        Runtime.bleManager?.mDevice.value == null ||
        Runtime.bleManager?.wwriteChar == null ||
        Runtime.bleManager?.mDevice.value?.isConnected == false) {
      navigateTo(RouteName.scanPage);
    } else {
      _releaseTimer();
      navigateTo(RouteName.modelPage);
    }
  }
  onCustomModelClick() {
    _releaseTimer();
    Get.dialog(
      CountDownConfirmDialog(
        onCancelCallBack: () {},
        onConfirmCallBack: () {
          slideItModel.value = 1;
          recordList.clear();
        },
      ),
    );
  }
  onSuperModelClick(){
    onSliverProcessChanged(1023.0);
  }
  onPlayClick(){}

}
