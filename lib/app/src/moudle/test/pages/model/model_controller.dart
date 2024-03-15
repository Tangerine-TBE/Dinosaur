import 'package:app_base/ble/ble_msg.dart';
import 'package:app_base/constant/run_time.dart';
import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelController extends BaseController {
  late PageController pageController;
  final currentModelPage = 0.obs;
  final process = 0.0.obs;
  final currentModel = 13.obs;
  final playModel = false.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    pageController.addListener(() {
      if (pageController.page! <= 0.1) {
        currentModelPage.value = 0;
      } else if (pageController.page! >= 0.9) {
        currentModelPage.value = 1;
      }
    });
  }

  changePage(int index) {
    var currentPage = currentModelPage.value;
    if(currentPage == index){
      return;
    }
    pageController.animateToPage(
      currentPage == 0 ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  onIndexItemClick(int index) {
    if(index < 0 ){
      showToast('已经是最前的模式了');
      return;
    }

    if(index > 12){
      showToast('已经是最后的模式了');
      return;
    }
    currentModel.value = index;
    if (Runtime.checkRuntimeBleEnable()) {
      Runtime.bleManager?.wwriteChar?.write(BleMSg().generateModelData(index));
    } else {
      showToast('请连接蓝牙设备!');
    }
  }

  onPlayClick() {
    playModel.value = !playModel.value;
    if (Runtime.checkRuntimeBleEnable()) {
      if (playModel.value) {
        Runtime.bleManager?.wwriteChar
            ?.write(BleMSg().generateModelData(currentModel.value));
      } else {
        Runtime.bleManager?.wwriteChar?.write(BleMSg().generateStopData());
      }
    } else {
      showToast('请连接蓝牙设备!');
    }
  }
  onNextClick(){
    onIndexItemClick(currentModel.value +1);
  }
  onLastClick(){
    onIndexItemClick(currentModel.value -1);
  }
}
