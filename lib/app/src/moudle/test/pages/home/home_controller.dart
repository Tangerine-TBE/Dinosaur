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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:status_bar_control/status_bar_control.dart';

class HomeController extends PlayDeviceBleController {
  final selectedTabIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() async {
    pageController = PageController();
    super.onInit();
  }

  toImageView(String url, String tag,int height,int  width) async{
    Get.lazyPut(() => ImageViewController(), tag: tag);
    final Route route = PageRouteBuilder(
        opaque:false,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ImageViewPage(
            tagString: tag,
            urlString: url,
           height:  height,
            width: width,
          ),
        );
      },
    );
    StatusBarControl.setHidden(true, animation:StatusBarAnimation.SLIDE);
   await Navigator.of(Get.context!).push(route);
    StatusBarControl.setHidden(false, animation:StatusBarAnimation.SLIDE);

  }
}
