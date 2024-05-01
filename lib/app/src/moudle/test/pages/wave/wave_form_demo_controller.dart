import 'dart:async';
import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/device/play_deivce_ble_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/wave/weight/wave_view.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import '../../device/ble_msg.dart';
import '../../device/run_time.dart';
enum TypicalClass{
  demoPreview,
  demoPlay,

}
class WaveFormDemoController extends PlayDeviceBleController {
  final List<int> list;
  final TypicalClass type ;
  WaveFormDemoController({required this.list,required this.type});
  final process = 0.obs;
  final ExternalWaveController waveController = ExternalWaveController();
  Timer? timer;
  final bleMsg = BleMSg();

  @override
  void onInit() {
    super.onInit();
    var i = 0;
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if(i == list.length){
        i = 0;
      }
      var cell = 255/1024;
      process.value = list[i];
      if(type == TypicalClass.demoPlay){
        if (list[i] > 50 || list[i]  > 50) {
          if (Runtime.deviceInfo.value?.isCanSubControl == true) {
            Runtime.deviceInfo.value?.writeChar.write(bleMsg.generateScale2Cmd(
                strengthValue: list[i] .toDouble(),
                subControlValue: list[i].toDouble()));
          } else if (Runtime.deviceInfo.value?.isCanAddHot == true) {
            Runtime.deviceInfo.value?.writeChar.write(bleMsg.generateScale2Cmd(
                strengthValue: list[i].toDouble(),
                hotControlValue: list[i].toDouble()));
          } else {
            Runtime.deviceInfo.value?.writeChar.write(bleMsg.generateScale2Cmd(
                strengthValue: list[i].toDouble()));
          }
        } else {
          Runtime.deviceInfo.value?.writeChar.write(
            bleMsg.generateStopData(),
          );
        }
      }else{
        Vibration.vibrate(duration: 200,amplitude: (cell*process.value).toInt());
      }
      i++;
    });
  }

  @override
  void onClose() {
    waveController.refresh();
    timer?.cancel();
    super.onClose();
  }
}
