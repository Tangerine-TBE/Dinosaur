import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:get/get.dart';

class Test2Controller extends BaseController {
  final process = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    while(true){
      await Future.delayed(const Duration(milliseconds: 200));
      process.value = Random().nextInt(500).toDouble();
    }
  }
}
