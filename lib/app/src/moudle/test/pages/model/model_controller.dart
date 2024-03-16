import 'dart:async';
import 'dart:math';
import 'package:app_base/ble/ble_manager.dart';
import 'package:app_base/ble/ble_msg.dart';
import 'package:app_base/constant/run_time.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_ble_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import '../sideIt/obxBean/double_bean.dart';

class ModelController extends BaseBleController {
  late PageController pageController; //主要用于监听页面变化的
  final currentModelPage = 0.obs; //主要用于与PageController联合作用，监听本次页面
  final Rx<DoubleBean> process = Rx(DoubleBean.create(obx: 0.0));
  final currentClassicModel = 13.obs; //当前在经典模式下选择的模式， 13 = 无
  final currentCustomModel = (-1).obs; //当前在自定义模式下选择的模式 0 = 默认第一个
  final playModel = false.obs; //主要用于改变播放键的形态
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
    processLoopCustomTimer?.cancel();
    processLoopClassicTimer?.cancel();
    currentClassicModel.value = index;
    if (currentClassicModel.value < 12) {
      if (bleManager.checkRuntimeBleEnable()) {
        // if (!playModel.value) {
        bleManager.wwriteChar
            ?.write(BleMSg().generateModelData(currentClassicModel.value));
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
          bleManager.wwriteChar?.write(mBleMsg.generateStopData());
        } else {
          if (bleManager.checkRuntimeBleEnable()) {
            // if (!playModel.value) {
            bleManager.wwriteChar
                ?.write(BleMSg().generateModelData(currentClassicModel.value));
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
      if (currentCustomModel < mRecordBean.dataList.length &&
          currentCustomModel >= 0) {
        if (playModel.value) {
          playModel.value = false;
          bleManager.wwriteChar?.write(mBleMsg.generateStopData());
        } else {
          if (bleManager.checkRuntimeBleEnable()) {
            bleManager.wwriteChar?.write(mBleMsg.generateStopData());
            showLoading(userInteraction: false);
            bleManager.wwriteChar?.write(mBleMsg.clearQueue());
            currentCustomModel.value = currentCustomModel.value;
            await sendCustomTemplate(currentCustomModel.value);
            playModel.value = true;
            bleManager.wwriteChar?.write(mBleMsg.generateAutoPlay());
            dismiss();
            int i = 0;
            if (processLoopCustomTimer == null) {
              processLoopCustomTimer = Timer.periodic(
                const Duration(milliseconds: 200),
                (timer) {
                  if (i >=
                      mRecordBean.dataList[currentCustomModel.value].recordList
                          .length) {
                    i = 0;
                  }
                  process.value = DoubleBean.create(
                      obx: mRecordBean
                          .dataList[currentCustomModel.value].recordList[i]
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
                        mRecordBean.dataList[currentCustomModel.value]
                            .recordList.length) {
                      i = 0;
                    }
                    process.value = DoubleBean.create(
                        obx: mRecordBean
                            .dataList[currentCustomModel.value].recordList[i]
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
    if (index < 0) {
      showToast('已经是最前的模式了');
      return;
    }
    if (index >= mRecordBean.dataList.length) {
      showToast('已经是最后的模式了');
      return;
    }
    if (bleManager.checkRuntimeBleEnable()) {
      // if (!playModel.value) {
      bleManager.wwriteChar?.write(mBleMsg.generateStopData());
      playModel.value = false;
      showLoading(userInteraction: false);
      currentCustomModel.value = index;
      bleManager.wwriteChar?.write(mBleMsg.clearQueue());
      await sendCustomTemplate(index);
      playModel.value = true;
      bleManager.wwriteChar?.write(mBleMsg.generateAutoPlay());
      dismiss();
      int i = 0;
      if (processLoopCustomTimer == null) {
        processLoopCustomTimer = Timer.periodic(
          const Duration(milliseconds: 200),
          (timer) {
            if (i >=
                mRecordBean
                    .dataList[currentCustomModel.value].recordList.length) {
              i = 0;
            }
            process.value = DoubleBean.create(
                obx: mRecordBean
                    .dataList[currentCustomModel.value].recordList[i]
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
                  mRecordBean
                      .dataList[currentCustomModel.value].recordList.length) {
                i = 0;
              }
              process.value = DoubleBean.create(
                  obx: mRecordBean
                      .dataList[currentCustomModel.value].recordList[i]
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
      onCustomModelClick(currentCustomModel.value + 1);
    }
  }

  onLastClick() {
    if (currentModelPage.value == 0) {
      onClassicItemClick(currentClassicModel.value - 1);
    } else {
      onCustomModelClick(currentCustomModel.value - 1);
    }
  }


  Future<void> sendCustomTemplate(int index) async {
    for (var i in mRecordBean.dataList[index].recordList) {
      logE('正在写入：$i');
     await bleManager.wwriteChar?.write(
        mBleMsg.generateStrengthSilentData(
          streamFirstValue: i,
          streamSecondValue: i,
        ),
      );
    }
  }

  @override
  void onAdapterStateChanged(BluetoothAdapterState state) {
  }
  @override
  void onDeviceConnected(BluetoothDevice device) async {
    dismiss();
    if (device.isConnected == true) {
      showToast('达成连接');
      List<BluetoothService> services = await device.discoverServices();
      services.forEach((service) {
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.characteristicUuid == Guid.fromString(BleMSg.writeUUID)) {
            manager.setWriteChar(c);
          }
        }
      });
    }
  }


  @override
  void onDeviceDisconnect() async {
    await Future.delayed(const Duration(seconds: 2));
    if(Runtime.lastConnectDevice.isNotEmpty){
      manager.startScan(timeout: 20);
    }
  }


  @override
  void onDeviceUnKnownError() {
  }

  @override
  void onScanResultChanged(List<ScanResult> result) async {
    logE('扫描有结果了');
    for (var element in result) {
      var resultDevice = element.device;
      if (resultDevice.platformName.startsWith(Runtime.lastConnectDevice)) {
        manager.stopScan();
        await Future.delayed(
          const Duration(seconds: 2),
        );
        manager.connect(resultDevice, 20);
      }
    }
  }
}
