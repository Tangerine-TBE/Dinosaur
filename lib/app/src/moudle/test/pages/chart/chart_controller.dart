import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/char_bean.dart';

class ChartController extends BaseController {
  late SingleCharManager singleCharManager;
  late DoubleCharManager doubleCharManager;
  late SpecialCharManager specialCharManager;

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
  final data = <SingleList>[];

  SingleCharManager({required this.controller});

  init() {
    if (!isInit) {
      getChartList();
      isInit = true;
    }
  }

  getChartList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    data.addAll(CharSingleBean.mock().dataList);
    controller.update([chartListId]);
    controller.dismiss();
  }
  onChartItemClick(int index) {
    controller.update([chartListId]);
  }
  onChartLikeClicked(int index){
    data[index].like = !data[index].like;
    controller.update([chartListId]);
  }
  onChartLinkClicked(int index){
    data[index].link =   !data[index].link;
    controller.update([chartListId]);
  }
}
class DoubleCharManager {
  bool isInit = false;
  final ChartController controller;
  final chartListId = 2;
  final data = <DoubleList>[];

  DoubleCharManager({required this.controller});

  init() {
    if (!isInit) {
      getChartList();
      isInit = true;
    }
  }

  getChartList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    data.addAll(CharDoubleBean.mock().dataList);
    controller.update([chartListId]);
    controller.dismiss();
  }

  onChartItemClick(int index) {
    controller.update([chartListId]);
  }
  onChartLikeClicked(int index){
    data[index].like = !data[index].like;
    controller.update([chartListId]);
  }
  onChartLinkClicked(int index){
    data[index].link =   !data[index].link;
    controller.update([chartListId]);
  }
}
class SpecialCharManager {
  bool isInit = false;
  final ChartController controller;
  final chartListId = 2;
  final data = <SpecialList>[];

  SpecialCharManager({required this.controller});

  init() {
    if (!isInit) {
      getChartList();
      isInit = true;
    }
  }

  getChartList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    data.addAll(CharSpecialBean.mock().dataList);
    controller.update([chartListId]);
    controller.dismiss();
  }

  onChartItemClick(int index) {
    controller.update([chartListId]);
  }
  onChartLikeClicked(int index){
    data[index].like = !data[index].like;
    controller.update([chartListId]);
  }
  onChartLinkClicked(int index){
    data[index].link =   !data[index].link;
    controller.update([chartListId]);
  }
}
