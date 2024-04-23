import 'dart:async';
import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/wave/weight/wave_view.dart';
import 'package:get/get.dart';

class WaveFormDemoController extends BaseController {
  final process = 0.obs;
  final ExternalWaveController waveController = ExternalWaveController();
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      process.value = Random().nextInt(1023);
    });
  }

  @override
  void onClose() {
    waveController.refresh();
    super.onClose();
  }
}
