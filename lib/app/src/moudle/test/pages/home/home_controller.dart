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
import 'package:dinosaur/app/src/moudle/test/pages/chart/chart_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/chart_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/message_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/message_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/mine_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/mine_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/pet_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/pet_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/play/play_controller.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import '../play/play_page.dart';

class HomeController extends PlayDeviceBleController {
  final selectedTabIndex = 0.obs;
  final _loginRepo = Get.find<LoginRepo>();
  final Map<String, Widget?> widgetList = {
    RouteName.playPage: null,
    RouteName.chartPage: null,
    RouteName.minePage: null,
    RouteName.petPage: null,
    RouteName.message: null,
  };

  @override
  void onInit() async {
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

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == RouteName.playPage) {
      return GetPageRoute(
        settings: settings,
        page: () {
          if(  widgetList[RouteName.playPage] == null){
            var page = const PlayPage();
            widgetList[RouteName.playPage] = page;
            return page;
          }else{
           return  widgetList[RouteName.playPage]!;
          }
        },
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => PlayController());
            Get.lazyPut(() => PlayRepo());
          },
        ),
        popGesture: false,
      );
    } else if (settings.name == RouteName.chartPage) {
      return GetPageRoute(
        settings: settings,
        page: () {
          if(  widgetList[RouteName.chartPage] == null){
            var page = const ChartPage();
            widgetList[RouteName.chartPage] = page;
            return page;
          }else{
            return  widgetList[RouteName.chartPage]!;
          }
        },
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => ChartController());
            Get.lazyPut(() => ChartRepo());
          },
        ),
        popGesture: false,
      );
    } else if (settings.name == RouteName.minePage) {
      return GetPageRoute(
        settings: settings,
        page: () {
          if(  widgetList[RouteName.minePage] == null){
            var page = const MinePage();
            widgetList[RouteName.minePage] = page;
            return page;
          }else{
            return  widgetList[RouteName.minePage]!;
          }
        },
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => MineController());
          },
        ),
        popGesture: false,
      );
    } else if (settings.name == RouteName.petPage) {
      return GetPageRoute(
        settings: settings,
        page: () {
          if(  widgetList[RouteName.petPage] == null){
            var page = const PetPage();
            widgetList[RouteName.petPage] = page;
            return page;
          }else{
            return  widgetList[RouteName.petPage]!;
          }
        },
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => PetController());
            Get.lazyPut(() => PushRepo());
          },
        ),
        popGesture: false,
      );
    } else if (settings.name == RouteName.message) {
      return GetPageRoute(
        settings: settings,
        page: () {
          if(  widgetList[RouteName.message] == null){
            var page = const MessagePage();
            widgetList[RouteName.message] = page;
            return page;
          }else{
            return  widgetList[RouteName.message]!;
          }
        },
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => MessageController());
            Get.lazyPut(() => PushRepo());
          },
        ),
        popGesture: false,
      );
    }
    return null;
  }
}
