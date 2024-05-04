import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/mvvm/repository/chart_repo.dart';
import 'package:app_base/mvvm/repository/play_repo.dart';
import 'package:app_base/mvvm/repository/push_repo.dart';
import 'package:dinosaur/app/src/moudle/test/device/play_deivce_ble_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeController extends PlayDeviceBleController {
  final selectedTabIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() async {
    pageController = PageController();
    super.onInit();
  }

  toImageView(String url, String tag) {
    Get.lazyPut(() => ImageViewController(), tag: tag);
    final Route route = PageRouteBuilder(
         pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
           return ImageViewPage(tagString: tag, urlString: url);
    });
    Navigator.of(Get.context!).push(route);
  }
}
