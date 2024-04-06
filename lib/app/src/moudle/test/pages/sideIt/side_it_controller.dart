import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:app_base/ble/ble_msg.dart';
import 'package:app_base/config/user.dart';
import 'package:app_base/constant/run_time.dart';
import 'package:app_base/mvvm/base_ble_controller.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:app_base/exports.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:dinosaur/app/src/moudle/test/pages/sideIt/obxBean/double_bean.dart';
import 'package:dinosaur/app/src/moudle/test/pages/sideIt/widget/count_down_confirm_dialog.dart';
import 'package:dinosaur/app/src/moudle/test/pages/sideIt/widget/create_custom_model_dialog.dart';
import 'package:dinosaur/app/src/moudle/test/pages/sideIt/widget/timer_controller.dart';
import 'package:app_base/mvvm/repository/model_repo.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
  final play = false.obs;
  bool isCustom = false;
  List<int> recordList = <int>[];
  final _repo = Get.find<ModelRepo>();

  Future<List<ui.Image>> loadImage(List<String> imagePath) async {
    var images = <ui.Image>[];
    for (int i = 0; i < imagePath.length; i++) {
      ByteData data = await rootBundle.load(imagePath[i]);
      Uint8List bytes = data.buffer.asUint8List();
      ui.Codec codec = await ui.instantiateImageCodec(bytes);
      ui.FrameInfo frameInfo = await codec.getNextFrame();
      images.add(frameInfo.image);
    }
    return images;
  }

  @override
  void onInit() async {
    super.onInit();
    countdownController = CountdownController();
  }

  _initTimer() {
    listen = true;
    loopTimer = Timer.periodic(
      const Duration(milliseconds: 200),
      (timer) {
        if (sliderValue.value > 50) {
           manager.wwriteChar?.write(
            bleMsg.generateStrengthData(
                streamFirstValue: sliderValue.value,
                streamSecondValue: sliderValue.value),
          );
        } else {
          manager.wwriteChar?.write(
            bleMsg.generateStopData(),
          );
        }
        process.value = DoubleBean.create(obx: sliderValue.value.toDouble());
      },
    );
  }

  _releaseTimer() {
    recordTimer?.cancel();
    loopTimer?.cancel();
    listen = false;
    manager.wwriteChar?.write(
      bleMsg.generateStopData(),
    );
  }

  onCountDownFinish() {
    slideItModel.value = 0;
    sliderValue.value = 0;
    recordTimer?.cancel();
    Get.dialog(
      CreateCustomModelDialog(
        onCancelCallBack: () {},
        onConfirmCallBack: (value) async {
          //创建订单
          final response = await _repo.sendModel(
            recordReq: RecordReq(
                kcal: 12.9,
                name: value,
                description: '',
                attribute: '',
                type: 'Single',
                actions: Data(record: recordList).toJsonString(),
                userId: User.loginRspBean!.userId,
                tags: '标签1'),
          );
          if (response.isSuccess) {
            EasyLoading.showSuccess('上传成功');
          }
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
    if (loopTimer == null) {
      _initTimer();
    } else {
      if (!loopTimer!.isActive) {
        _initTimer();
      }
    }
    if (!play.value) {
      play.value = true;
    }
    sliderValue.value = process.toInt();
  }

  onSliverDown() async {
    if (slideItModel.value == 1) {
      countdownController.resume();
      int i = 0;
      recordTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
        i++;
        if (sliderValue.value > 50) {
          recordList.add(sliderValue.value);
        } else {
          recordList.add(0);
        }
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
    if (!manager.checkRuntimeBleEnable()) {
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
    play.value = false;
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

  onPlayClick() {
    if (!play.value) {
      //开始循环
      _initTimer();
    } else {
      _releaseTimer();
    }
    play.value = !play.value;
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
    //对扫描结果进行一次判断
    for (var element in result) {
      var resultDevice = element.device;
      if (Runtime.lastConnectDevice.isNotEmpty &&
          resultDevice.platformName.startsWith(Runtime.lastConnectDevice)) {
        manager.stopScan();
        await Future.delayed(
          const Duration(seconds: 2),
        );
        manager.connect(resultDevice, 20);
      }
    }
  }
}
