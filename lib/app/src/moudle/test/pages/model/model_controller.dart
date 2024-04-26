import 'dart:async';
import 'dart:math';
import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/repository/model_repo.dart';
import 'package:dinosaur/app/src/moudle/test/device/play_deivce_ble_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import '../../device/ble_manager.dart';
import '../../device/ble_msg.dart';
import '../../device/run_time.dart';
import '../sideIt/obxBean/double_bean.dart';

class ModelController extends PlayDeviceBleController {
  final customPageId = 1;

  // late PageController pageController; //主要用于监听页面变化的
  final currentModelPage = 0.obs; //主要用于与PageController联合作用，监听本次页面
  final Rx<DoubleBean> process = Rx(DoubleBean.create(obx: 0.0));
  final currentClassicModel = 13.obs; //当前在经典模式下选择的模式， 13 = 无
  final currentCustomModel = (-1).obs; //当前在自定义模式下选择的模式 0 = 默认第一个
  final playModel = false.obs; //主要用于改变播放键的形态
  late BleMSg mBleMsg; //主要用于蓝牙指令的生成
  Timer? processLoopClassicTimer; //主要用于与process作用改变chartPainter的形态
  Timer? processLoopCustomTimer; //与上相同
  final BleManager bleManager = BleManager();
  late TabController tabController;
  final listData = 1;
  final _repo = Get.find<ModelRepo>();
  List<ModeList> modelList = [];

  @override
  void onInit() {
    super.onInit();
    mBleMsg = BleMSg();
    _fetchModel();
  }

  _fetchModel() async {
    final response = await _repo.getModel(
      recordReq: ModelReq(
          orderBy: 'createTime desc', userId: User.loginRspBean!.userId),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        modelList.addAll(response.data!.data!.modeList);
        update([customPageId]);
      }
    }
  }

  changePage(int index) {
    var currentPage = currentModelPage.value;
    if (currentPage == index) {
      return;
    }
    // pageController.animateToPage(
    //   currentPage == 0 ? 1 : 0,
    //   duration: const Duration(milliseconds: 500),
    //   curve: Curves.ease,
    // );
  }

  onClassicItemClick(int index) {
    if (index < 0) {
      showToast('已经是最前的模式了');
      return;
    }

    if (index >= 12) {
      showToast('已经是最后的模式了');
      return;
    }
    processLoopCustomTimer?.cancel();
    processLoopClassicTimer?.cancel();
    if (currentClassicModel.value==13 ||currentClassicModel.value < 12) {
      if (Runtime.checkRuntimeBleEnable()) {
        // if (!playModel.value) {
        currentClassicModel.value = index;
        update([listData]);
        Runtime.deviceInfo.value!.writeChar
            .write(BleMSg().generateModelData(currentClassicModel.value));
        if (processLoopClassicTimer == null) {
          processLoopClassicTimer = Timer.periodic(
            const Duration(milliseconds: 200),
            (timer) {
              process.value =
                  DoubleBean.create(obx: Random().nextInt(1023).toDouble());
            },
          );
        } else {
          if (!processLoopClassicTimer!.isActive) {
            processLoopClassicTimer = Timer.periodic(
              const Duration(milliseconds: 200),
              (timer) {
                process.value =
                    DoubleBean.create(obx: Random().nextInt(1023).toDouble());
              },
            );
          }
        }
        if (!playModel.value) {
          playModel.value = !playModel.value;
        }
      } else {
        showToast('请连接蓝牙设备!');
      }
    } else {
      showToast('请选择模式!');
    }
  }

  @override
  onClose() {
    processLoopCustomTimer?.cancel();
    processLoopClassicTimer?.cancel();
    super.onClose();
  }

  onPlayClick() async {
    processLoopClassicTimer?.cancel();
    processLoopCustomTimer?.cancel();
    if (currentModelPage.value == 0) {
      if (currentClassicModel < 13) {
        if (playModel.value) {
          Runtime.deviceInfo.value!.writeChar.write(mBleMsg.generateStopData());
        } else {
          if (Runtime.checkRuntimeBleEnable()) {
            // if (!playModel.value) {
            await   Runtime.deviceInfo.value!.writeChar
                .write(BleMSg().generateModelData(currentClassicModel.value));
            processLoopClassicTimer = Timer.periodic(
              const Duration(milliseconds: 200),
              (timer) {
                process.value =
                    DoubleBean.create(obx: Random().nextInt(1023).toDouble());
              },
            );
          } else {
            showToast('请连接蓝牙设备!');
          }
        }
        playModel.value = !playModel.value;
      } else {
        showToast('请选择模式!');
      }
    } else {
      if (currentCustomModel < modelList.length && currentCustomModel >= 0) {
        if (playModel.value) {
          playModel.value = false;
          await   Runtime.deviceInfo.value!.writeChar.write(mBleMsg.generateStopData());
        } else {
          if (Runtime.checkRuntimeBleEnable()) {
            Runtime.deviceInfo.value!.writeChar.write(mBleMsg.generateStopData());
            showLoading(userInteraction: false);
            Runtime.deviceInfo.value!.writeChar.write(mBleMsg.clearQueue());
            currentCustomModel.value = currentCustomModel.value;
            await sendCustomTemplate(currentCustomModel.value);
            playModel.value = true;
            Runtime.deviceInfo.value!.writeChar.write(mBleMsg.generateAutoPlay());
            dismiss();
            int i = 0;
            if (processLoopCustomTimer == null) {
              processLoopCustomTimer = Timer.periodic(
                const Duration(milliseconds: 200),
                (timer) {
                  if (i >=
                      modelList[currentCustomModel.value]
                          .actions
                          .record
                          .length) {
                    i = 0;
                  }
                  process.value = DoubleBean.create(
                      obx: modelList[currentCustomModel.value]
                          .actions
                          .record[i]
                          .toDouble());
                  i++;
                },
              );
            } else {
              if (!processLoopCustomTimer!.isActive) {
                processLoopCustomTimer = Timer.periodic(
                  const Duration(milliseconds: 200),
                  (timer) {
                    if (i >=
                        modelList[currentCustomModel.value]
                            .actions
                            .record
                            .length) {
                      i = 0;
                    }
                    process.value = DoubleBean.create(
                        obx: modelList[currentCustomModel.value]
                            .actions
                            .record[i]
                            .toDouble());

                    i++;
                  },
                );
              }
            }
          } else {
            showToast('请连接蓝牙设备!');
          }
        }
      } else {
        showToast('请选择模式!');
      }
    }
  }

  onCustomModelClick(int index) async {
    processLoopCustomTimer?.cancel();
    processLoopClassicTimer?.cancel();
    //先发送停止
    if (Runtime.checkRuntimeBleEnable()) {
      // if (!playModel.value) {
      Runtime.deviceInfo.value!.writeChar.write(mBleMsg.generateStopData());
      playModel.value = false;
      showLoading(userInteraction: false);
      update([customPageId]);
      currentCustomModel.value = index;
      Runtime.deviceInfo.value!.writeChar.write(mBleMsg.clearQueue());
      await sendCustomTemplate(index);
      playModel.value = true;
      Runtime.deviceInfo.value!.writeChar.write(mBleMsg.generateAutoPlay());
      dismiss();
      int i = 0;
      if (processLoopCustomTimer == null) {
        processLoopCustomTimer = Timer.periodic(
          const Duration(milliseconds: 200),
          (timer) {
            if (i >=
                modelList[currentCustomModel.value]
                    .actions
                    .record
                    .length) {
              i = 0;
            }
            process.value = DoubleBean.create(
                obx:  modelList[currentCustomModel.value]
                    .actions
                    .record[i]
                    .toDouble());

            logE('当前数据为：${process.value.obx}');
            i++;
          },
        );
      } else {
        if (!processLoopCustomTimer!.isActive) {
          processLoopCustomTimer = Timer.periodic(
            const Duration(milliseconds: 200),
            (timer) {
              if (i >=
                  modelList[currentCustomModel.value]
                      .actions
                      .record
                      .length) {
                i = 0;
              }
              process.value = DoubleBean.create(
                  obx:  modelList[currentCustomModel.value]
                      .actions
                      .record[i]
                      .toDouble());
              i++;
            },
          );
        }
      }
    } else {
      showToast('请连接蓝牙设备!');
    }
  }

  onNextClick() {
    //判断当前页面
    if (currentModelPage.value == 0) {
      onClassicItemClick(currentClassicModel.value + 1);
    } else {
      if( currentCustomModel.value != -1 && currentCustomModel.value + 1 >=modelList.length  ){
        showToast('当前已经是最后一个模式了');
      }else{
        if(currentCustomModel.value == -1){
          onCustomModelClick(0);
        }else{
          onCustomModelClick(currentCustomModel.value + 1);
        }
      }
    }
  }

  onLastClick() {
    if (currentModelPage.value == 0) {
      onClassicItemClick(currentClassicModel.value - 1);
    } else {
      if(currentCustomModel.value != -1 && currentCustomModel.value -1 <0){
        showToast('当前已经是最前的一个模式了');
      }else{
        if(currentCustomModel.value ==-1){
          onCustomModelClick(0);
        }else{
          onCustomModelClick(currentCustomModel.value - 1);
        }
      }
    }
  }

  Future<void> sendCustomTemplate(int index) async {
    for (var i in modelList[index]
        .actions.record) {
      logE('正在写入：$i');
      await  Runtime.deviceInfo.value!.writeChar.write(
        mBleMsg.generateStrengthSilentData(
          streamFirstValue: i,
          streamSecondValue: i,
        ),
      );
    }
  }
}
