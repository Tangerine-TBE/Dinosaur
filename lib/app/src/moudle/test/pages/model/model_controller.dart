import 'dart:async';
import 'dart:math';

import 'package:app_base/ble/ble_manager.dart';
import 'package:app_base/ble/ble_msg.dart';
import 'package:app_base/constant/run_time.dart';
import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_base/mvvm/model/record_bean.dart';

class ModelController extends BaseController {
  late PageController pageController; //主要用于监听页面变化的
  final currentModelPage = 0.obs;//主要用于与PageController联合作用，监听本次页面
  final process = 0.0.obs;//主要用于ChartPainter的使用
  final currentClassicModel = 13.obs; //当前在经典模式下选择的模式， 13 = 无
  final currentCustomModel = 0.obs; //当前在自定义模式下选择的模式 0 = 默认第一个
  final playModel = false.obs;//主要用于改变播放键的形态
  late RecordBean mRecordBean; //主要用于存储自定义模式的信息
  late BleMSg mBleMsg; //主要用于蓝牙指令的生成
  Timer? processLoopClassicTimer; //主要用于与process作用改变chartPainter的形态
  Timer? processLoopCustomTimer; //与上相同
  final BleManager bleManager = BleManager();
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
    dynamic data = SaveKey.dataList.read;
    if (data.runtimeType.toString() == 'Null') {
      mRecordBean = RecordBean(dataList: []);
    } else {
      mRecordBean = RecordBean.fromJson(data);
    }
    mBleMsg = BleMSg();
  }

  changePage(int index) {
    var currentPage = currentModelPage.value;
    if (currentPage == index) {
      return;
    }
    pageController.animateToPage(
      currentPage == 0 ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  onClassicItemClick(int index) {
    if (index < 0) {
      showToast('已经是最前的模式了');
      return;
    }

    if (index > 12) {
      showToast('已经是最后的模式了');
      return;
    }
    currentClassicModel.value = index;
    onPlayClick();
  }
  @override
  onClose(){
    processLoopCustomTimer?.cancel();
    processLoopClassicTimer?.cancel();
    super.onClose();
  }

  onPlayClick() async {
    //1.判断当前页面
    if (currentModelPage.value == 0) {
      //经典模式下
      if (currentClassicModel.value <= 12) {
        if (bleManager.checkRuntimeBleEnable()) {
          if (!playModel.value) {
            bleManager.wwriteChar
                ?.write(BleMSg().generateModelData(currentClassicModel.value));
            processLoopClassicTimer = Timer.periodic(
              const Duration(milliseconds: 200),
              (timer) {
                process.value = Random().nextInt(1023).toDouble();
              },
            );
          } else {
            processLoopCustomTimer?.cancel();
            bleManager.wwriteChar?.write(mBleMsg.generateStopData());
          }
          playModel.value = !playModel.value;
        } else {
          showToast('请连接蓝牙设备!');
        }
      } else {
        showToast('请选择模式!');
      }
    } else {
      if (mRecordBean.dataList.isNotEmpty) {
        if (bleManager.checkRuntimeBleEnable()) {
          if (!playModel.value) {
            bleManager.wwriteChar?.write(mBleMsg.generateStopData());
            playModel.value = false;
            showLoading(userInteraction: false);
            await sendCustomTemplate(currentCustomModel.value);
            playModel.value = true;
            bleManager.wwriteChar?.write(mBleMsg.generateAutoPlay());
            dismiss();
            int i = 0;
            processLoopCustomTimer = Timer.periodic(
              const Duration(milliseconds: 200),
              (timer) {
                if(i >= mRecordBean.dataList[currentCustomModel.value].recordList.length){
                  i = 0;
                }
                process.value = mRecordBean
                    .dataList[currentCustomModel.value].recordList[i]
                    .toDouble();
                i++;
              },
            );
          } else {
            processLoopCustomTimer?.cancel();
            bleManager.wwriteChar?.write(mBleMsg.generateStopData());
          }
          playModel.value = !playModel.value;
        } else {
          showToast('请连接蓝牙设备!');
        }
      } else {
        showToast('当前还没有自定义模式哦!');
      }
    }
  }
  onCustomModelClick(int index) async {
    //先发送停止
    if (index < 0) {
      showToast('已经是最前的模式了');
      return;
    }
    if (index >= mRecordBean.dataList.length) {
      showToast('已经是最后的模式了');
      return;
    }
    currentCustomModel.value = index;
    onPlayClick();
  }

  onNextClick() {
    //判断当前页面
    if (currentModelPage.value == 0) {
      onClassicItemClick(currentClassicModel.value + 1);
    } else {
      onCustomModelClick(currentClassicModel.value + 1);
    }
  }

  onLastClick() {
    if (currentModelPage.value == 0) {
      onClassicItemClick(currentClassicModel.value - 1);
    } else {
      onCustomModelClick(currentClassicModel.value - 1);
    }
  }


  Future<void> sendCustomTemplate(int index) async {
    for (var i in mRecordBean.dataList[index].recordList) {
      bleManager.wwriteChar?.write(
        mBleMsg.generateStrengthSilentData(
          streamFirstValue: i,
          streamSecondValue: i,
        ),
      );
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }
}
