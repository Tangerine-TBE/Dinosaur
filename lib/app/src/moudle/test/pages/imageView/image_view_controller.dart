import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ImageViewController extends BaseController{
  final isZoomed = false.obs;
  final tapCount = 0.obs;
  final position =  Offset(0, 0).obs;
  late TransformationController  transformationController;
  @override
  void onInit() {
    transformationController = TransformationController();
    super.onInit();
  }
}