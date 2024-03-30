
import 'package:app_base/config/res_name.dart';
import 'package:app_base/mvvm/base_controller.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:app_base/mvvm/model/friends_share_bean.dart';

class PetController extends BaseController{
  late CommonManager commonManager;
  late DynamicManager dynamicManager;
  late HandPickManager handPickManager;
  late RefreshManager refreshManager;
  @override
  void onInit() {
    commonManager = CommonManager(controller: this);
    dynamicManager = DynamicManager(controller: this);
    handPickManager = HandPickManager(controller: this);
    refreshManager = RefreshManager(controller: this);
    commonManager.init();
    super.onInit();
  }

  onPageChanged(int index) {
    if (index == 0) {
      commonManager.init();
    } else if (index == 1) {
      dynamicManager.init();
    } else if (index == 2) {
      handPickManager.init();
    }else if(index ==3 ){
      refreshManager.init();
    }
  }
}
class CommonManager {
  bool isInit = false;
  final PetController controller;
  final listId = 1;
  final dataList =<Recommon>[];
  CommonManager({required this.controller});
  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }
  getList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    dataList.addAll(RecommonRsp.mock().recommon);
    controller.update([listId]);
    controller.dismiss();
  }
  List<BannerModel> get listBanners {
    return [
      BannerModel(imagePath: ResName.homeAdd0, id: "1",boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd1, id: "2",boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd2, id: "3",boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd3, id: "4",boxFit: BoxFit.cover),
    ];
  }
}
class DynamicManager {
  bool isInit = false;
  final PetController controller;
  final listId = 2;
  DynamicManager({required this.controller});
  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }
  getList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    controller.update([listId]);
    controller.dismiss();
  }
}
class HandPickManager {
  bool isInit = false;
  final PetController controller;
  final listId = 3;
  HandPickManager({required this.controller});
  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }
  getList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    controller.update([listId]);
    controller.dismiss();
  }
}
class RefreshManager{
  bool isInit = false;
  final PetController controller;
  final listId = 4;
  RefreshManager({required this.controller});
  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }
  getList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    controller.update([listId]);
    controller.dismiss();
  }
}