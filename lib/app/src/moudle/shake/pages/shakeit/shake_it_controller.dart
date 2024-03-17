
import 'dart:async';
import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:get/get.dart';
class ShakeItController extends BaseController{
  final threshold = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(milliseconds:200   ), (timer) {
      threshold.value = Random(300).nextDouble();
    });


  }
}