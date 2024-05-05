import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum Model{
  picTransformScale,
  unKnow
}
class ImageViewController extends BaseController{
  final isZoomed = false.obs;
  final tapCount = 0.obs;
  final position =  const Offset(0, 0).obs;
  final dragStartPosition = const Offset(0, 0).obs;
  var canDrag = false;
  var canDoubleTap = false;
  var pointerDrag = true;
  Model dragModel= Model.unKnow;
  late TransformationController  transformationController;
  @override
  void onInit()  {
    transformationController = TransformationController();
    super.onInit();
  }
  @override
  void onClose() {
    transformationController.dispose();
    super.onClose();
  }
}