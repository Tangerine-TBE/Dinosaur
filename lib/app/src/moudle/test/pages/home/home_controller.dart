import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/home_bean.dart';
import 'package:app_base/mvvm/repository/home_repo.dart';
import 'package:dinosaur/app/src/moudle/test/device/play_deivce_ble_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:status_bar_control/status_bar_control.dart';

class HomeController extends PlayDeviceBleController {
  final selectedTabIndex = 0.obs;
  late PageController pageController;
  final _repo = Get.find<HomeRepo>();
  double? currentPage = 0.0;

  @override
  void onInit() {
    pageController = PageController();

    super.onInit();
  }

  @override
  void onReady() {
    pageController.addListener(() {
      if (currentPage == 3) {
        SaveKey.loginUserExtendsInfo.save(User.loginUserInfo?.toJson());
      }
      currentPage = pageController.page;
    });
    _fetchUserData();
    super.onReady();
  }

  _fetchUserData() async {
    final HomeReq homeReq = HomeReq(id: User.loginRspBean!.userId);
    final response = await apiLaunch(() => _repo.getUserInfo(homeReq: homeReq),
        enableLoading: true);
    if (response != null) {
      if (response.data != null) {
        final HomeRsp? homeRsp = response.data;
        if (homeRsp != null) {
          SaveKey.loginUserExtendsInfo.save(response.data!.toJson());
          User.loginUserInfo = response.data;
        }
      }
    }
    if (User.loginUserInfo == null) {
      var info = SaveKey.loginUserExtendsInfo.read;
      if (info != null) {
        User.loginUserInfo = HomeRsp.fromJson(SaveKey.loginUserBaseInfo.read);
      } else {
        //没有缓存信息，则
        showToast('登录出错!');
        offAllNavigateTo(RouteName.login);
      }
    }
  }

  toImageView(String url, String tag, int height, int width) async {
    Get.lazyPut(() => ImageViewController(), tag: tag);
    final Route route = PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ImageViewPage(
            tagString: tag,
            urlString: url,
          ),
        );
      },
    );
     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),);
    StatusBarControl.setHidden(true, animation: StatusBarAnimation.FADE);
    await Navigator.of(Get.context!).push(route);
    StatusBarControl.setHidden(false, animation: StatusBarAnimation.FADE);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),);

  }
}
