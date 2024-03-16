import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:app_base/ble/ble_manager.dart';
import 'package:app_base/ble/ble_msg.dart';
import 'package:app_base/constant/constants.dart';
import 'package:app_base/mvvm/base_ble_controller.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:app_base/exports.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/obxBean/double_bean.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/widget/count_down_confirm_dialog.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/widget/create_custom_model_dialog.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/widget/timer_controller.dart';

class SideItController extends BaseBleController {
  final slideItModel = 0.obs;
  final sliderValue = 0.obs;
  final Rx<DoubleBean> process = Rx(DoubleBean.create(obx: 0.0));
  final bleMsg = BleMSg();
  bool loopSending = true;
  final customPaintId = 1;
  Timer? loopTimer;
  Timer? recordTimer;
  late CountdownController countdownController;
  final BleManager bleManager = BleManager();


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
    countdownController = CountdownController();
    _initTimer();
  }

  _initTimer() {
    listen = true;
    loopTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if(sliderValue.value > 50){
        bleManager.wwriteChar?.write(
          bleMsg.generateStrengthData(
              streamFirstValue: sliderValue.value,
              streamSecondValue: sliderValue.value),
        );
      }else{
        bleManager.wwriteChar?.write(
          bleMsg.generateStopData(),
        );
      }
      process.value = DoubleBean.create(obx: sliderValue.value.toDouble());
    });
  }

  _releaseTimer() {
    recordTimer?.cancel();
    loopTimer?.cancel();
    listen = false;
    int i = 5;
    while (i >= 0) {
      bleManager.wwriteChar?.write(
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
          if (data.runtimeType.toString() == 'Null') {
            recordBean = RecordBean(dataList: []);
          } else {
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

  onSliverDown() async {
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

  onClassicClick() async {
    if (bleManager.mDevice == null ||
        bleManager.wwriteChar == null ||
        bleManager.mDevice?.isConnected == false) {
      _releaseTimer();
      await navigateForResult(RouteName.scanPage);
      _initTimer();
    } else {
      _releaseTimer();
      await navigateForResult(RouteName.modelPage);
      _initTimer();
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

  onSuperModelClick() {
    onSliverProcessChanged(1023.0);
  }

  onPlayClick() {}

  @override
  void onAdapterStateChanged(BluetoothAdapterState state) {

  }

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
    logE('正在开始重新扫描');
    manager.startScan(timeout: 20);
  }

  @override
  void onDeviceUnKnownError() {
  }

  @override
  void onScanResultChanged(List<ScanResult> result) async {
    //对扫描结果进行一次判断
    logE('扫描有结果了');
    for (var element in result) {
      var resultDevice = element.device;
      if (resultDevice.platformName.startsWith(Constants.bleSearchName)) {
          manager.stopScan();
          await Future.delayed(const Duration(seconds: 2),);
          manager.connect(resultDevice, 20);
      }
    }

  }
}
