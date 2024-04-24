import 'dart:convert';

import 'package:app_base/ble/ble_manager.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/chart_bean.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:app_base/mvvm/repository/chart_repo.dart';
import 'package:dinosaur/app/src/moudle/test/device/run_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChartController extends BaseController {
  late SingleCharManager singleCharManager;
  late DoubleCharManager doubleCharManager;
  late SpecialCharManager specialCharManager;
  final chartRepo = Get.find<ChartRepo>();

  @override
  void onInit() {
    singleCharManager = SingleCharManager(controller: this);
    doubleCharManager = DoubleCharManager(controller: this);
    specialCharManager = SpecialCharManager(controller: this);
    singleCharManager.init();
    super.onInit();
  }

  onPageChanged(int index) {
    if (index == 0) {
      singleCharManager.init();
    } else if (index == 1) {
      doubleCharManager.init();
    } else if (index == 2) {
      specialCharManager.init();
    }
  }
}

class SingleCharManager {
  bool isInit = false;
  final ChartController controller;
  final chartListId = 1;
  final data = <WaveList>[];

  SingleCharManager({required this.controller});

  init() {
    if (!isInit) {
      getChartList();
      isInit = true;
    }
  }

  getChartList() async {
    final response = await controller.apiLaunch(
      () => controller.chartRepo.getCharts(
        ChartReq(
            pageIndex: 1,
            pageSize: 10,
            orderBy: 'createTime desc',
            type: 'Single'),
      ),
    );
    if (response?.data?.waveList != null) {
      data.addAll(response!.data!.waveList);
      controller.update([chartListId]);
    }
  }

  onChartItemClick(int index) {
    if (Runtime.deviceInfo.value == null) {
      Get.dialog(
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 180,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Icon(
                      Icons.cancel_outlined,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                Text(
                  '玩具未连接',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('没有玩具，可以减用手机震动预览波形'),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: Colors.grey,
                        minWidth: 100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                            side: BorderSide(color: Colors.black)),
                        onPressed: () async {
                          Get.back();
                          await controller.navigateForResult(RouteName.scanPage);
                          if(Runtime.deviceInfo.value != null){
                              controller.navigateTo(RouteName.waveDemo,args: Data.fromJson(json.decode(data[index].actions)).record);
                          }
                        },
                        child: Text('去连接'),
                      ),
                      MaterialButton(
                        minWidth: 100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                            side: BorderSide(color: Colors.black)),
                        color: Colors.green,
                        onPressed: ()  {
                          Get.back();
                           controller.navigateForResult(RouteName.waveDemo,
                              args: Data.fromJson(
                                      json.decode(data[index].actions))
                                  .record);

                        },
                        child: Text('预览'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {}

    // controller.navigateTo(RouteName.waveDemo);
    // controller.update([chartListId]);
  }

  onChartLikeClicked(int index) {
    // data[index].like = !data[index].like;
    // controller.update([chartListId]);
  }

  onChartLinkClicked(int index) {
    // data[index].link = !data[index].link;
    // controller.update([chartListId]);
  }
}

class DoubleCharManager {
  bool isInit = false;
  final ChartController controller;
  final chartListId = 2;
  final data = <WaveList>[];

  DoubleCharManager({required this.controller});

  init() {
    if (!isInit) {
      getChartList();
      isInit = true;
    }
  }

  getChartList() async {
    final response = await controller.apiLaunch(
      () => controller.chartRepo.getCharts(
        ChartReq(
            pageIndex: 1,
            pageSize: 10,
            orderBy: 'createTime desc',
            type: 'Double'),
      ),
    );
    if (response?.data?.waveList != null) {
      data.addAll(response!.data!.waveList);
      controller.update([chartListId]);
    }
  }

  onChartItemClick(int index) {
    controller.update([chartListId]);
  }

  onChartLikeClicked(int index) {
    // data[index].like = !data[index].like;
    // controller.update([chartListId]);
  }

  onChartLinkClicked(int index) {
    // data[index].link = !data[index].link;
    // controller.update([chartListId]);
  }
}

class SpecialCharManager {
  bool isInit = false;
  final ChartController controller;
  final chartListId = 2;
  final data = <WaveList>[];

  SpecialCharManager({required this.controller});

  init() {
    if (!isInit) {
      getChartList();
      isInit = true;
    }
  }

  getChartList() async {
    final response = await controller.apiLaunch(
      () => controller.chartRepo.getCharts(
        ChartReq(
            pageIndex: 1,
            pageSize: 10,
            orderBy: 'createTime desc',
            type: 'Suction'),
      ),
    );
    if (response?.data?.waveList != null) {
      data.addAll(response!.data!.waveList);
      controller.update([chartListId]);
    }
  }

  onChartItemClick(int index) {
    controller.update([chartListId]);
  }

  onChartLikeClicked(int index) {
    // data[index].like = !data[index].like;
    // controller.update([chartListId]);
  }

  onChartLinkClicked(int index) {
    // data[index].link = !data[index].link;
    // controller.update([chartListId]);
  }
}
