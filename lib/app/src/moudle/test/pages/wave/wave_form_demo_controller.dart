import 'dart:async';
import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/wave/weight/wave_view.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class WaveFormDemoController extends BaseController {
  final List<int> list;
  WaveFormDemoController({required this.list});


  final process = 0.obs;
  final ExternalWaveController waveController = ExternalWaveController();
  Timer? timer;

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
      Vibration.vibrate(duration: 100,amplitude: (cell*process.value).toInt());
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
